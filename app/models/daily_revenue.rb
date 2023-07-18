class DailyRevenue < ApplicationRecord
  belongs_to :restaurant

  validates :date, presence: true
  validates :revenue, presence: true
end
