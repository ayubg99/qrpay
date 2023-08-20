class AddDescriptionToFoodTypes < ActiveRecord::Migration[5.2]
  def change
    add_column :food_types, :description, :text
  end
end
