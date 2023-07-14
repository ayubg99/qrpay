class SpecialMenu < ApplicationRecord
  belongs_to :restaurant
  has_many :food_types, dependent: :destroy
  has_many :cart_items, dependent: :destroy
  has_many :order_special_menus, dependent: :destroy
  has_many :orders, through: :order_special_menus
  has_many :deleted_order_special_menus, dependent: :destroy
  has_many :deleted_orders, through: :deleted_order_special_menus
  
  has_one_attached :image

  validates :name, presence: true
  validates :price, presence: true
  validates :start_hour, presence: true
  validates :end_hour, presence: true
  validates :image, presence: true

  def in_time_range?
    current_hour = Time.now.hour
    start_hour_hour = start_hour.hour
    end_hour_hour = end_hour.hour
    current_hour >= start_hour_hour && current_hour <= end_hour_hour
  end
end
