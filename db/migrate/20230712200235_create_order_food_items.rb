class CreateOrderFoodItems < ActiveRecord::Migration[5.2]
  def change
    create_table :order_food_items do |t|
      t.references :order, foreign_key: true
      t.references :food_item, foreign_key: true

      t.timestamps
    end
  end
end
