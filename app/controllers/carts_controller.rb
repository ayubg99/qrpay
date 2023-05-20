class CartsController < ApplicationController
    before_action :set_restaurant
    def show
        @cart = current_cart
        @cart_items = @cart.cart_items.includes(:food_item, :special_menu)

        respond_to do |format|
            format.html
            format.json { render json: { cart_items: @cart_items } }
          end
    end
    
      def add_to_cart
        @cart = @restaurant.carts.find_or_create_by(session_id: session[:cart_id])
    
        food_item_id = params[:food_item_id]
        special_menu_id = params[:special_menu_id]
    
        if food_item_id.present?
          food_item = FoodItem.find_by(id: food_item_id)
          @cart_item = @cart.cart_items.build(food_item: food_item)
        elsif special_menu_id.present?
          special_menu = SpecialMenu.find_by(id: special_menu_id)
          @cart_item = @cart.cart_items.build(special_menu: special_menu)
        end
    
        if @cart_item && @cart.save
          respond_to do |format|
            format.html { redirect_to @restaurant, notice: 'Item added to cart successfully' }
            format.json { render json: { message: 'Item added to cart successfully' } }
          end
        else
          respond_to do |format|
            format.html { redirect_to @restaurant, alert: 'Failed to add item to cart' }
            format.json { render json: { error: 'Failed to add item to cart' }, status: :unprocessable_entity }
          end
        end
      end
    
      def remove_from_cart
        @cart = current_cart
        @cart_item = @cart.cart_items.find(params[:id])
        @cart_item.destroy
        redirect_to @cart
      end

    private
        def set_restaurant 
            @restaurant = Restaurant.friendly.find(params[:restaurant_id])
        end
end
