class Managemant < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :budget, presence: true
  validates :result, presence: true
  validates :result_date, presence: true
end
