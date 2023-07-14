class DeletedOrderSpecialMenu < ApplicationRecord
  belongs_to :deleted_order
  belongs_to :special_menu
end
