class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :food_item, optional: true
  belongs_to :special_menu, optional: true
end
