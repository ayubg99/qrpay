class Category < ApplicationRecord
  belongs_to :restaurant
  has_many :food_items, dependent: :destroy

  before_save :name_uppercase

  def name_uppercase 
    self.name = self.name.upcase
  end
end
