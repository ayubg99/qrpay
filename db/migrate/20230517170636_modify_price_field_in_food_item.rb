class ModifyPriceFieldInFoodItem < ActiveRecord::Migration[5.2]
  def change
    change_column :food_items, :price, :decimal, :precision => 8, :scale => 2
  end
end
