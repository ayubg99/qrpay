class DailyRevenue < ApplicationRecord
  belongs_to :restaurant

  validates :day, presence: true
  validates :month, presence: true
  validates :year, presence: true
  validates :date, presence: true
  validates :revenue, presence: true
end
