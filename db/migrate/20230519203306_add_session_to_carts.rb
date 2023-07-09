class AddSessionToCarts < ActiveRecord::Migration[5.2]
  def change
    add_column :carts, :session_id, :string
  end
end
