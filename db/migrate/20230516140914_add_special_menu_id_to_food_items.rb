class AddSpecialMenuIdToFoodItems < ActiveRecord::Migration[5.2]
  def change
    add_column :food_items, :special_menu_id, :integer
  end
end
