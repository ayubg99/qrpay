class CreateFoodTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :food_types do |t|
      t.string :name
      t.references :special_menu, foreign_key: true

      t.timestamps
    end
  end
end
