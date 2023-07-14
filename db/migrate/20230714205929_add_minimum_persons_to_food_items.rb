class AddMinimumPersonsToFoodItems < ActiveRecord::Migration[5.2]
  def change
    add_column :food_items, :minimum_persons, :integer
  end
end
