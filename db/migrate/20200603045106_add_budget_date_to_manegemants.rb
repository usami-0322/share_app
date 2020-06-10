class AddBudgetDateToManegemants < ActiveRecord::Migration[5.2]
  def change
    add_column :manegemants, :budget_date, :date
    add_column :manegemants, :result_date, :date
  end
end
