class Category < ApplicationRecord
  belongs_to :restaurant
  has_many :food_items, dependent: :destroy
end
