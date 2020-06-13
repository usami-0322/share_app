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

  def self.latest_budget
    pluck(:budget).first.to_i
  end

  def self.latest_result_date
    pluck(:result_date).first
  end

  def self.latest_result
    pluck(:result).first.to_i
  end

  def self.total_sales
    sales = group("YEAR(created_at)").group("MONTH(result_date)").sum(:result)
    sales.values.last.to_i
  end

  # def self.daily_budget
  #   today = self.latest_result_date
  #   if @managemants.pluck(:result_date).empty?
  #     returen 0
  #   else
  #     last_day = Date.new(today.year, today.month, -1)
  #     days_left = (last_day - today).to_i
  #     (self.latest_budget - current_user.managemants.total_sales) / days_left
  #   end
  # end
end
