class AddStartHourAndEndHourToSpecialMenus < ActiveRecord::Migration[5.2]
  def change
    add_column :special_menus, :start_hour, :time
    add_column :special_menus, :end_hour, :time
  end
end
