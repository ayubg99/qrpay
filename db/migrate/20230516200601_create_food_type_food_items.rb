class CreateFoodTypeFoodItems < ActiveRecord::Migration[5.2]
  def change
    create_table :food_type_food_items do |t|
      t.references :food_item, foreign_key: true
      t.references :food_type, foreign_key: { on_delete: :cascade }

      t.timestamps
    end
  end
end
