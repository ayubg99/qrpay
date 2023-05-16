class SpecialMenuItem < ApplicationRecord
  belongs_to :special_menu
  belongs_to :food_item 
  validates :special_menu, uniqueness: { scope: :food_item }
end
