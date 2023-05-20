class Cart < ApplicationRecord
  belongs_to :restaurant
  has_many :cart_items

  def total_price
    total_price = 0

    cart_items.each do |cart_item|
      if cart_item.food_item.present?
        total_price += cart_item.food_item.price
      elsif cart_item.special_menu.present?
        total_price += cart_item.special_menu.price
      end
    end

    total_price
  end
end
