class AddPaymentMethodAndTotalPriceToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :payment_method, :string
    add_column :orders, :total_price, :decimal, :precision => 8, :scale => 2
  end
end
