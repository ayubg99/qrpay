class AddTableNumberToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :table_number, :integer
  end
end
