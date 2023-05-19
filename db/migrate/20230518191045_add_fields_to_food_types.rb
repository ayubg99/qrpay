class AddFieldsToFoodTypes < ActiveRecord::Migration[5.2]
  def change
    add_column :food_types, :have_to_select_one, :boolean
  end
end
