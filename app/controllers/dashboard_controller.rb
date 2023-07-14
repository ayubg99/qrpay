class DashboardController < ApplicationController
    before_action :authenticate_restaurant!

    def index
        @restaurant = current_restaurant
        @orders_today = current_restaurant.deleted_orders.where("DATE(created_at) = ?", Date.today)
        @orders_month = current_restaurant.deleted_orders.where("EXTRACT(MONTH FROM created_at) = ?", Date.today.month)
        @sum_today = @orders_today.sum(:total_price)
        @sum_month = @orders_month.sum(:total_price)
        @revenue_today = @sum_today - (@sum_today * 0.02)
        @revenue_month = @sum_month - (@sum_month * 0.02)
    end

    def orders
        @restaurant = current_restaurant
        @orders = @restaurant.orders
    end

    def history
        @restaurant = current_restaurant
        @deleted_orders = @restaurant.deleted_orders.order(order_date: :desc)
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

    def payment_information
        @restaurant = current_restaurant
    end
    
    def update_payment_information
        @restaurant = current_restaurant
        if @restaurant.update(payment_information_params)
          redirect_to dashboard_path, notice: 'Payment information updated successfully!'
        else
          render :payment_information
        end
    end

    private

    def payment_information_params
        params.require(:restaurant).permit(:stripe_account_id, :bank_account_number, :bank_routing_number, :bank_account_holder_name)
    end
end