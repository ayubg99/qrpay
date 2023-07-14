class AddMinimumPersonsToSpecialMenus < ActiveRecord::Migration[5.2]
  def change
    add_column :special_menus, :minimum_persons, :integer
  end
end
