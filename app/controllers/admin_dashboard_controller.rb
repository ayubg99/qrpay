class AdminDashboardController < ApplicationController
    before_action :authenticate_admin!
    
    def index
        @restaurants = Restaurant.all
        @current_day_revenue = DailyRevenue.where(day: Date.today.day, month: Date.today.month, year: Date.today.year).sum(:revenue) * 0.02
        @current_month_revenue = MonthlyRevenue.where(month: Date.today.month, year: Date.today.year).sum(:revenue) * 0.02
        @current_year_revenue = MonthlyRevenue.where(year: Date.today.year).sum(:revenue) * 0.02
        @revenues = DailyRevenue.where(month: Date.today.month, year: Date.today.year)
                            .pluck(:date, :revenue)
    end

    def restaurants
        @restaurants = Restaurant.all
    end

    def contacts
        @contacts = Contact.all
    end
end