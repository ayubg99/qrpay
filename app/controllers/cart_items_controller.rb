class CartItemsController < ApplicationController
    def create
        @cart = current_cart
        
        if params[:food_item_id].present?
          @cart_item = @cart.cart_items.find_or_initialize_by(food_item_id: params[:food_item_id])
        elsif params[:special_menu_id].present?
          @cart_item = @cart.cart_items.find_or_initialize_by(special_item_id: params[:special_menu_id])
        end
    
        @cart_item.quantity += 1
    
        if @cart_item.save
          respond_to do |format|
            format.html { redirect_to restaurant_cart_path(@cart.restaurant, @cart), notice: 'Item was successfully added to cart.' }
            format.js
          end
        else
          redirect_to restaurant_cart_path(@cart.restaurant, @cart), alert: 'Failed to add item to cart.'
        end
    end
    
    def destroy
        @cart = current_cart
        @cart_item = @cart.cart_items.find(params[:id])
        @cart_item.destroy
        respond_to do |format|
          format.html { redirect_to restaurant_cart_path(@cart_item.cart.restaurant, @cart_item.cart), notice: 'Item was successfully removed from cart.' }
          format.js
        end
    end
end
