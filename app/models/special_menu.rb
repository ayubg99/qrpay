class SpecialMenu < ApplicationRecord
  belongs_to :restaurant
  has_many :special_menu_items, dependent: :destroy
  has_many :food_items, through: :special_menu_items

  accepts_nested_attributes_for :special_menu_items, allow_destroy: true
end
