class CreateSpecialMenus < ActiveRecord::Migration[5.2]
  def change
    create_table :special_menus do |t|
      t.string :name
      t.references :restaurant, foreign_key: true

      t.timestamps
    end
  end
end
