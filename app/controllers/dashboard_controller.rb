class DashboardController < ApplicationController
    before_action :authenticate_restaurant!

    def index
        @restaurant = current_restaurant
    end

    def orders
        @restaurant = current_restaurant
        @orders = @restaurant.orders
    end

    def tables
        @restaurant = current_restaurant
    end

    def menu
        @restaurant = current_restaurant
    end 

    def special_menus
        @restaurant = current_restaurant
    end
end