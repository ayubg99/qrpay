class DeletedOrderFoodItem < ApplicationRecord
  belongs_to :deleted_order
  belongs_to :food_item
end
