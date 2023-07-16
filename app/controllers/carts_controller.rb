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
    @cart = current_cart
    update_cart_activity(@cart)

    if params[:food_item_id].present?
      @cart_item = @cart.add_food_item(params[:food_item_id])
      if @cart_item.save
        render json: { cart_item: @cart_item, food_item: @cart_item.cart_item_food_items.first.food_item, remove_url: remove_from_cart_restaurant_cart_path(@restaurant, @cart_item), total_price: @cart.total_price }
      else
        render json: { error: 'Failed to add item to cart' }, status: :unprocessable_entity
      end
    elsif params[:special_menu_id].present?
      @cart_item = @cart.add_special_menu(params[:special_menu_id], params[:food_item_ids])
      if @cart_item.save
        render json: { cart_item: @cart_item, special_menu: @cart_item.special_menu, food_items: @cart_item.food_items, remove_url: remove_from_cart_restaurant_cart_path(@restaurant, @cart_item), total_price: @cart.total_price }
      else
        render json: { error: 'Failed to add item to cart' }, status: :unprocessable_entity   
      end
    end
  end


 

  def remove_from_cart
    @cart = current_cart
    @cart_item = @cart.cart_items.find(params[:id])
    @cart_item.destroy

    render json: { total_price: @cart.total_price }
  end

  def clear_cart
    @cart = current_cart
    @cart.cart_items.destroy_all

    respond_to do |format|
      format.html { redirect_back(fallback_location: @restaurant) }
      format.json { render json: { success: true } }
    end
  end

  private

  def set_restaurant 
    @restaurant = Restaurant.friendly.find(params[:restaurant_id])
  end

  def update_cart_activity(cart)
    cart.update(last_active_at: Time.current) if cart.persisted?
  end
end