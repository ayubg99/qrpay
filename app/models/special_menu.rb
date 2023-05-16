class SpecialMenu < ApplicationRecord
  belongs_to :restaurant
  has_many :food_types
end
