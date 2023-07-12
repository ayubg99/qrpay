class SpecialMenu < ApplicationRecord
  belongs_to :restaurant
  has_many :food_types, dependent: :destroy
  has_many :cart_items, dependent: :destroy
  
  has_one_attached :image
end
