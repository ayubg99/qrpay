class AdminDashboardController < ApplicationController
    before_action :authenticate_admin!
    
    def index
        @restaurants = Restaurant.all

        @restaurants_with_provider = Restaurant.where.not(provider_id: nil)
        @restaurants_without_provider = Restaurant.where(provider_id: nil)

        @current_day_revenue = @restaurants_with_provider.joins(:daily_revenues)
        .where(daily_revenues: { day: Date.today.day, month: Date.today.month, year: Date.today.year })
        .sum('daily_revenues.revenue') * 0.015 + @restaurants_without_provider.joins(:daily_revenues)
        .where(daily_revenues: { day: Date.today.day, month: Date.today.month, year: Date.today.year })
        .sum('daily_revenues.revenue') * 0.02   
        
        @current_month_revenue = @restaurants_with_provider.joins(:daily_revenues)
        .where(daily_revenues: { month: Date.today.month, year: Date.today.year })
        .sum('daily_revenues.revenue') * 0.015 + @restaurants_without_provider.joins(:daily_revenues)
        .where(daily_revenues: { month: Date.today.month, year: Date.today.year })
        .sum('daily_revenues.revenue') * 0.02 
        @current_year_revenue = @restaurants_with_provider.joins(:daily_revenues)
        .where(daily_revenues: { year: Date.today.year })
        .sum('daily_revenues.revenue') * 0.015 + @restaurants_without_provider.joins(:daily_revenues)
        .where(daily_revenues: { year: Date.today.year })
        .sum('daily_revenues.revenue') * 0.02 
    end

    def restaurants
        @restaurants = Restaurant.all
    end

    def contacts
        @contacts = Contact.all
    end
end