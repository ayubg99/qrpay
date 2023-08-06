class AddPaymentMethodToDeletedOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :deleted_orders, :payment_method, :string
  end
end
