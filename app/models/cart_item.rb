class CartItem < ApplicationRecord
  belongs_to :order, optional: true
  belongs_to :deleted_order, optional: true
  belongs_to :special_menu, optional: true
  belongs_to :food_type, optional: true
  belongs_to :cart
  has_many :cart_item_food_items, dependent: :destroy
  has_many :food_items, through: :cart_item_food_items
end