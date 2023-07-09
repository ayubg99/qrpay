class RemoveSessionFromCarts < ActiveRecord::Migration[5.2]
  def change
    remove_column :carts, :session_id
  end
end
