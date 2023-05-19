class FoodType < ApplicationRecord
  belongs_to :special_menu
  has_many :food_type_food_items, dependent: :destroy
  has_many :food_items, through: :food_type_food_items
  accepts_nested_attributes_for :food_type_food_items, allow_destroy: true

  validates :name, presence: true
end
