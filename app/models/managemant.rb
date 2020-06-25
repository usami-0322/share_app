class Managemant < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :budget, presence: true
  validates :result, presence: true
  validates :result_date, presence: true

  def self.search
    order(result_date: :desc)
  end

  # chartkick用データ
  def self.chart_date
    order(result_date: :asc).pluck('result_date', 'result').to_h
  end

  # 最近の予算
  def self.latest_budget
    pluck(:budget).first.to_i
  end

  # 最近の売上日
  def self.latest_result_date
    pluck(:result_date).first
  end

  # 最近の売上
  def self.latest_result
    pluck(:result).first.to_i
  end

  # 月間売上
  def self.total_sales
    sales = group("YEAR(created_at)").group("MONTH(result_date)").sum(:result)
    sales.values.last.to_i
  end

  # 日割予算
  def self.daily_budget(params: params)
    today = order(result_date: :desc).pluck(:result_date).first
    # 入力値が空の場合
    if ransack(params).result(distinct: true).paginate(page: params).pluck(:result_date).empty?
      return 0
    else
      last_day = Date.new(today.year, today.month, -1)
      days_left = (last_day - today).to_i
      if days_left == 0
        return 0
      else
        sales = group("YEAR(created_at)").group("MONTH(result_date)").sum(:result)
        total_sales = sales.values.last.to_i
        return (order(result_date: :desc).pluck(:budget).first.to_i - total_sales) / days_left
      end
    end
  end

  # 進捗率
  def self.progress_rate(params: params)
    month = Date.new(Time.now.year, Time.now.month, -1).mday.to_f
    if ransack(params).result(distinct: true).paginate(page: params).pluck(:result_date).empty?
      return 0
    else
      sort_latest_budget = order(result_date: :desc).latest_budget
      today_day = order(result_date: :desc).latest_result_date.mday.to_f
      return (total_sales.to_f / (sort_latest_budget.to_f / month * today_day) * 100).round(1)
    end
  end
end
