class FoodItem < ApplicationRecord
  belongs_to :restaurant
  belongs_to :category
  has_one_attached :image
end
