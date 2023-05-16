class FoodTypeFoodItem < ApplicationRecord
  belongs_to :food_item
  belongs_to :food_type

  validates :food_type, uniqueness: { scope: :food_item }
end
