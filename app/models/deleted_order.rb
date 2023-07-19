class DeletedOrder < ApplicationRecord
    belongs_to :restaurant
    has_many :cart_items, dependent: :destroy

    after_create :store_revenue

    private 

    def store_revenue
        date = Date.today
        current_day = Date.today.day
        current_month = Date.today.month
        current_year = Date.today.year

        daily_revenue = restaurant.daily_revenues.find_or_initialize_by(date: date, day: current_day, month: current_month, year: current_year)
        daily_revenue.revenue = (daily_revenue.revenue || 0) + total_price
        daily_revenue.save

        monthly_revenue = restaurant.monthly_revenues.find_or_initialize_by(month: current_month, year: current_year)
        monthly_revenue.revenue = restaurant.daily_revenues.where(month: current_month, year: current_year).sum(:revenue)
        monthly_revenue.save
    end
end