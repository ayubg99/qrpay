class CreateFoodItems < ActiveRecord::Migration[5.2]
  def change
    create_table :food_items do |t|
      t.string :name
      t.text :description
      t.integer :price
      t.references :restaurant, foreign_key: true

      t.timestamps
    end
  end
end
