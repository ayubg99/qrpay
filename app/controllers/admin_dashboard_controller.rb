class AdminDashboardController < ApplicationController
    before_action :authenticate_admin!
    
    def index
        @restaurants = Restaurant.all
    end 
end