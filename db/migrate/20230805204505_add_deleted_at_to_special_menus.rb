class AddDeletedAtToSpecialMenus < ActiveRecord::Migration[5.2]
  def change
    add_column :special_menus, :deleted_at, :datetime
    add_index :special_menus, :deleted_at
  end
end
