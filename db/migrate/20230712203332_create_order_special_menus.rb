class CreateOrderSpecialMenus < ActiveRecord::Migration[5.2]
  def change
    create_table :order_special_menus do |t|
      t.references :order, foreign_key: true
      t.references :special_menu, foreign_key: true

      t.timestamps
    end
  end
end
