class AddFieldsToSpecialMenus < ActiveRecord::Migration[5.2]
  def change
    add_column :special_menus, :price, :decimal, :precision => 8, :scale => 2
    add_column :special_menus, :instructions, :text
    add_column :special_menus, :description, :text
  end
end
