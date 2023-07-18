class DeletedOrder < ApplicationRecord
    belongs_to :restaurant
    has_many :cart_items, dependent: :destroy

    after_create :store_daily_revenue
    after_create :store_daily_revenue

    private 

    def store_daily_revenue
        date = created_at.to_date
        daily_revenue = restaurant.daily_revenues.find_or_initialize_by(date: date)
        daily_revenue.revenue = (daily_revenue.revenue || 0) + total_price
        daily_revenue.save
    end

    def store_monthly_revenue
        if created_at.end_of_month == Time.current.end_of_month
          month = created_at.beginning_of_month
          monthly_revenue = restaurant.monthly_revenues.find_or_initialize_by(month: month)
          monthly_revenue.revenue = restaurant.daily_revenues.where(date: month..Time.current.end_of_month).sum(:revenue)
          monthly_revenue.save
        end
    end
end