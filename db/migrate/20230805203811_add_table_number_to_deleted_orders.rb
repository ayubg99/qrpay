class AddTableNumberToDeletedOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :deleted_orders, :table_number, :integer
  end
end
