class AddResultDateToManagemants < ActiveRecord::Migration[5.2]
  def change
    add_column :managemants, :result_date, :date
  end
end
