class CreateCartItems < ActiveRecord::Migration[5.2]
  def change
    create_table :cart_items do |t|
      t.references :cart, foreign_key: true
      t.references :food_item, foreign_key: true
      t.references :special_menu, foreign_key: true
      t.integer :quantity

      t.timestamps
    end
  end
end
