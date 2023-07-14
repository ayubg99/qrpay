class CreateSpecialMenuFoodItems < ActiveRecord::Migration[5.2]
  def change
    create_table :special_menu_food_items do |t|
      t.references :special_menu, foreign_key: true
      t.references :food_item, foreign_key: true

      t.timestamps
    end
  end
end
