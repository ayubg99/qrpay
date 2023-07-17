class Order < ApplicationRecord
  belongs_to :restaurant
  has_many :cart_items, dependent: :nullify

  before_destroy :create_order_history

  	def add_cart_items_from_cart(cart)
		cart.cart_items.each do |item|
			item.cart_id = nil
			cart_items << item
		end
	end

	def create_order_history
        deleted_order = DeletedOrder.create( 
          restaurant_id: restaurant_id,
          total_price: total_price,
          order_date: created_at
        )

        cart_items.each do |cart_item| 
          deleted_order.cart_items << cart_item
        end

        deleted_order.save
    end
end
