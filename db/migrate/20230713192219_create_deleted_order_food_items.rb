class CreateDeletedOrderFoodItems < ActiveRecord::Migration[5.2]
  def change
    create_table :deleted_order_food_items do |t|
      t.references :deleted_order, foreign_key: true
      t.references :food_item, foreign_key: true

      t.timestamps
    end
  end
end
