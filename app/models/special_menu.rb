class SpecialMenu < ApplicationRecord
  belongs_to :restaurant
  has_many :food_types, dependent: :destroy
  has_many :cart_items, dependent: :destroy
  has_many :order_special_menus, dependent: :destroy
  has_many :orders, through: :order_special_menus
  has_many :deleted_order_special_menus, dependent: :destroy
  has_many :deleted_orders, through: :deleted_order_special_menus
  
  has_one_attached :image
end
