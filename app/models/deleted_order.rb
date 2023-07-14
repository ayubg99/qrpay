class DeletedOrder < ApplicationRecord
    belongs_to :restaurant
    has_many :deleted_order_food_items, dependent: :destroy
    has_many :food_items, through: :deleted_order_food_items
    has_many :deleted_order_special_menus, dependent: :destroy
    has_many :special_menus, through: :deleted_order_special_menus
end