class AddDeletedOrderToCartItems < ActiveRecord::Migration[5.2]
  def change
    add_reference :cart_items, :deleted_order, foreign_key: true
  end
end
