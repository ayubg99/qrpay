class SpecialMenuFoodItem < ApplicationRecord
  belongs_to :special_menu
  belongs_to :food_item
end
