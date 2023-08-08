class Image < ApplicationRecord
  belongs_to :special_menu
  has_one_attached :image
end
