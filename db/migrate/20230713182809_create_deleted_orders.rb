class CreateDeletedOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :deleted_orders do |t|
      t.string :name
      t.string :email
      t.integer :restaurant_id
      t.decimal :total_price, :precision => 8, :scale => 2
      t.date :order_date

      t.timestamps
    end
  end
end
