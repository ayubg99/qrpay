class MonthlyRevenue < ApplicationRecord
  belongs_to :restaurant

  validates :month, presence: true
  validates :year, presence: true
  validates :revenue, presence: true
end
