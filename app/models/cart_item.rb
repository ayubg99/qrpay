class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :special_menu, optional: true
  belongs_to :food_type, optional: true
  has_many :cart_item_food_items
  has_many :food_items, through: :cart_item_food_items
end
