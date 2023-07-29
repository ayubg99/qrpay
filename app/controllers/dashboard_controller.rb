class DashboardController < ApplicationController
    before_action :authenticate_restaurant_if_no_admin
    before_action :check_password, only: [:index, :payment_information]
    before_action :set_restaurant

    def index
        @current_day_revenue = @restaurant.daily_revenues.where(day: Date.today.day, month: Date.today.month, year: Date.today.year).sum(:revenue)
        @current_month_revenue = @restaurant.monthly_revenues.where(month: Date.today.month, year: Date.today.year).sum(:revenue)
        @current_year_revenue = @restaurant.monthly_revenues.where(year: Date.today.year).sum(:revenue)


        @popular_food_items = FoodItem.joins(:cart_items)
        .where(food_items: { restaurant_id: @restaurant.id })
        .group('food_items.id')
        .order('SUM(cart_items.quantity) DESC')
        .limit(5)

        @popular_special_menus = SpecialMenu.joins(:cart_items)
                      .where(special_menus: { restaurant_id: @restaurant.id })
                      .group('special_menus.id')
                      .order('SUM(cart_items.quantity) DESC')
                      .limit(5)


        @revenues = @restaurant.daily_revenues.where(month: Date.today.month, year: Date.today.year)
                            .pluck(:date, :revenue)
    end

    def authenticate
        password = params[:password]
        if @restaurant.valid_password?(password)
          session[:authenticated] = true
        else
          session[:authenticated] = false
        end
        redirect_to request.referrer || restaurant_dashboard_path(@restaurant)
    end

    def unauthenticate
        password = params[:password]
        if @restaurant.valid_password?(password)
          session[:authenticated] = false
        end
        redirect_to request.referrer || restaurant_dashboard_path(@restaurant)
    end

    def orders
        @orders = @restaurant.orders.order(created_at: :desc)
    end

    def history
        @deleted_orders = @restaurant.deleted_orders.order(order_date: :desc)
    end

    def tables
    end

    def menu
    end 

    def special_menus
    end

    def payment_information
    end
    
    def update_payment_information        
        if @restaurant.valid_password?(params[:restaurant][:current_password])
          if @restaurant.update(payment_information_params)
            redirect_to restaurant_dashboard_payment_information_path(@restaurant), notice: 'Payment information updated successfully!'
          else
            render :payment_information
          end
        else
          @restaurant.errors.add(:current_password, 'is incorrect')
          render :payment_information
        end
    end

    private

    def set_restaurant 
      @restaurant = Restaurant.friendly.find(params[:restaurant_id])
    end

    def payment_information_params
        params.require(:restaurant).permit(:stripe_account_id, :bank_account_number, :bank_routing_number, :bank_account_holder_name)
    end

    def check_password
        unless session[:authenticated]
          @show_revenue = false
        end
    end
end