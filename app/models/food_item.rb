class FoodItem < ApplicationRecord
  belongs_to :restaurant
  belongs_to :category
  has_many :food_type_food_items, dependent: :destroy
  has_many :food_types, through: :food_type_food_items

  has_one_attached :image
end
