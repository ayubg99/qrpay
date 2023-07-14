class FoodItem < ApplicationRecord
  belongs_to :restaurant
  belongs_to :category
  has_many :food_type_food_items, dependent: :destroy
  has_many :food_types, through: :food_type_food_items
  has_many :cart_item_food_items, dependent: :destroy
  has_many :cart_items, through: :cart_item_food_items
  has_many :order_food_items, dependent: :destroy
  has_many :orders, through: :order_food_items
  has_many :deleted_order_food_items, dependent: :destroy
  has_many :deleted_orders, through: :deleted_order_food_items
  has_many :special_menu_food_items, dependent: :destroy
  
  has_one_attached :image

  before_save :name_uppercase

  def name_uppercase 
    self.name = self.name.upcase
  end
end
