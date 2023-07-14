class OrderSpecialMenu < ApplicationRecord
  belongs_to :order
  belongs_to :special_menu
end
