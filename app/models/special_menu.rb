class SpecialMenu < ApplicationRecord
  belongs_to :restaurant
  has_many :food_types
  has_one_attached :image
end
