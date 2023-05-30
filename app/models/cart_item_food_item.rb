class CartItemFoodItem < ApplicationRecord
  belongs_to :cart_item
  belongs_to :food_item
end
