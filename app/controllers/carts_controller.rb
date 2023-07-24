class CartsController < ApplicationController
  before_action :set_restaurant
  before_action :set_cart

  def show
    @cart_items = @cart.cart_items.includes(:food_item, :special_menu)

    respond_to do |format|
      format.html
      format.json { render json: { cart_items: @cart_items } }
    end
  end
  
  def add_to_cart
    update_cart_activity(@cart)

    if params[:food_item_id].present?
      @cart_item = @cart.add_food_item(params[:food_item_id])
      if @cart_item.save
        render json: { restaurant_id: @restaurant.friendly_id, quantity: @cart_item.quantity, cart_item: @cart_item, food_item: @cart_item.cart_item_food_items.first.food_item, remove_url: remove_from_cart_restaurant_cart_path(@restaurant, @cart_item), total_price: @cart.total_price }
      else
        render json: { error: 'Failed to add item to cart' }, status: :unprocessable_entity
      end
    elsif params[:special_menu_id].present?
      @cart_item = @cart.add_special_menu(params[:special_menu_id], params[:food_item_ids])
      if @cart_item.save
        render json: { quantity: @cart_item.quantity, cart_item: @cart_item, special_menu: @cart_item.special_menu, food_items: @cart_item.food_items, remove_url: remove_from_cart_restaurant_cart_path(@restaurant, @cart_item), total_price: @cart.total_price }
      else
        render json: { error: 'Failed to add item to cart' }, status: :unprocessable_entity   
      end
    end
  end

  def remove_from_cart
    food_item_id = params[:food_item_id]
    @cart_item = @cart.remove_food(food_item_id)
    
    if @cart_item.save
      render json: { food_item_id: food_item_id, quantity: @cart_item.quantity, cart_item: @cart_item, food_item: @cart_item.cart_item_food_items.first.food_item, total_price: @cart.total_price }
    else 
      render json: { food_item_id: food_item_id, quantity: 0, total_price: @cart.total_price  }
    end
  end

  def remove_special_menu
    special_menu_id = params[:special_menu_id]
    @cart_item = @cart.remove_special_menu(special_menu_id)
    
    if @cart_item.save
      render json: { special_menu_id: special_menu_id, quantity: @cart_item.quantity, cart_item: @cart_item, special_menu: @cart_item.special_menu, total_price: @cart.total_price }
    else
      render json: { special_menu_id: special_menu_id, quantity: 0, total_price: @cart.total_price  }
    end
  end

  def clear_cart
    @cart.cart_items.destroy_all

    respond_to do |format|
      format.html { redirect_back(fallback_location: @restaurant) }
      format.json { render json: { success: true } }
    end
  end

  def destroy
    @cart.destroy if @cart.id == session[:cart_id]
    session[:cart_id] = nil
    respond_to do |format|
      format.html { redirect_to @restaurant }
      format.json { head :no_content }
    end
  end

  private

  def set_cart
    @cart = current_cart
  end

  def set_restaurant 
    @restaurant = Restaurant.friendly.find(params[:restaurant_id])
  end

  def update_cart_activity(cart)
    cart.update(last_active_at: Time.current) if cart.persisted?
  end
end