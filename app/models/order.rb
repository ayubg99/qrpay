class Order < ApplicationRecord
  belongs_to :restaurant
  has_many :order_food_items, dependent: :destroy
  has_many :food_items, through: :order_food_items
  has_many :order_special_menus, dependent: :destroy
  has_many :special_menus, through: :order_special_menus
end
