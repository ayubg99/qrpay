class Category < ApplicationRecord
  belongs_to :restaurant
  has_many :food_items, dependent: :destroy

  validates :name, presence: true

  def name_uppercase 
    self.name = self.name.upcase
  end
end
