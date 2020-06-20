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
end
