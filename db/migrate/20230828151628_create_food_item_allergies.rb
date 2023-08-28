class CreateFoodItemAllergies < ActiveRecord::Migration[5.2]
  def change
    create_table :food_item_allergies do |t|
      t.references :food_item, foreign_key: true
      t.references :allergy, foreign_key: true
    end
  end
end
