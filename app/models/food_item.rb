class FoodItem < ApplicationRecord
  belongs_to :restaurant
  belongs_to :category
  has_many :food_type_food_items, dependent: :destroy
  has_many :food_types, through: :food_type_food_items
  has_many :cart_item_food_items, dependent: :destroy
  has_many :cart_items, through: :cart_item_food_items
  has_many :special_menu_food_items, dependent: :destroy
  
  has_one_attached :image
    
  validates :name, presence: true
  validates :price, presence: true
  
  def name_uppercase 
    self.name = self.name.upcase
  end

  def soft_delete
    update(deleted_at: Time.now)
  end

  def active?
    deleted_at.nil?
  end
end