class AddLastActiveAtToCarts < ActiveRecord::Migration[5.2]
  def change
    add_column :carts, :last_active_at, :datetime
  end
end
