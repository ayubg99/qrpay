class Cart < ApplicationRecord
  belongs_to :restaurant
  has_many :cart_items, dependent: :destroy
  has_many :cart_item_food_items, through: :cart_items

  def total_price
    total_price = 0

    cart_items.each do |cart_item|
      if cart_item.special_menu.present?
        total_price += cart_item.special_menu.price
      elsif cart_item.food_items.present?
        cart_item.food_items.each do |food_item| 
          total_price += food_item.price
        end
      end
    end
    total_price
  end
end
