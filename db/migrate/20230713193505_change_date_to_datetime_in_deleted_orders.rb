class ChangeDateToDatetimeInDeletedOrders < ActiveRecord::Migration[5.2]
  def change
    change_column :deleted_orders, :order_date, :datetime
  end
end
