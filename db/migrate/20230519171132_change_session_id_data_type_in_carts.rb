class ChangeSessionIdDataTypeInCarts < ActiveRecord::Migration[5.2]
  def change
    change_column :carts, :session_id, :string, default: '', null: false
  end

  def down
    remove_column :carts, :session_id
  end
end
