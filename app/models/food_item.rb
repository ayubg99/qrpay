class FoodItem < ApplicationRecord
  belongs_to :restaurant
  belongs_to :category
  has_many :food_type_food_items, dependent: :destroy
  has_many :food_types, through: :food_type_food_items
  has_many :cart_item_food_items, dependent: :destroy
  has_many :cart_items, through: :cart_item_food_items
  has_many :special_menu_food_items, dependent: :destroy
  
  has_one_attached :image
  before_save :name_uppercase
  before_destroy :clear_food_item

  validates :name, presence: true
  validates :price, presence: true
  
  def name_uppercase 
    self.name = self.name.upcase
  end

  def clear_food_item
    cart_items.update_all(food_item_id: nil)
  end
end