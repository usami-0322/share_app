class CreateManegemants < ActiveRecord::Migration[5.2]
  def change
    create_table :manegemants do |t|
      t.integer :budget
      t.integer :result
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
