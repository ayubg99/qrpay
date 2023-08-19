class Category < ApplicationRecord
  belongs_to :restaurant
  has_many :food_items, dependent: :destroy

  before_save :name_uppercase

  validates :name, presence: true

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
