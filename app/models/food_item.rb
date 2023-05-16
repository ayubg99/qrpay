class FoodItem < ApplicationRecord
  belongs_to :restaurant
  belongs_to :category
  has_many :special_menu_items, dependent: :destroy
  has_many :special_menus, through: :special_menu_items
  
  has_one_attached :image
end
