class CreateDeletedOrderSpecialMenus < ActiveRecord::Migration[5.2]
  def change
    create_table :deleted_order_special_menus do |t|
      t.references :deleted_order, foreign_key: true
      t.references :special_menu, foreign_key: true

      t.timestamps
    end
  end
end
