class CreateCartItemFoodItems < ActiveRecord::Migration[5.2]
  def change
    create_table :cart_item_food_items do |t|
      t.references :cart_item, foreign_key: true, foreign_key: { on_delete: :cascade }
      t.references :food_item, foreign_key: true

      t.timestamps
    end
  end
end
