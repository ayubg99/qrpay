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
      food_item = FoodItem.find_by(id: params[:food_item_id])
      if food_item.present?
        @cart_item = @cart.cart_items.build
        @cart_item.cart_item_food_items.build(food_item: food_item)
      end
    end
    if @cart_item && @cart.save
      render json: { message: 'Item added to cart successfully' }
    else
      render json: { error: 'Failed to add item to cart' }, status: :unprocessable_entity
    end
  end

  def add_special_menu_to_cart
    @cart = current_cart
    update_cart_activity(@cart)
  
    special_menu_id = params[:special_menu_id]
    if special_menu_id.present?
      special_menu = SpecialMenu.find_by(id: special_menu_id)
      @cart_item = @cart.cart_items.build(special_menu: special_menu)
      food_item_ids = params[:food_item_ids]
      
      if food_item_ids.present?
        food_item_ids.each do |food_type_id, food_item_id|
          food_type = FoodType.find_by(id: food_type_id)
          food_item = food_type.food_items.find_by(id: food_item_id)
          @cart_item.cart_item_food_items.build(food_item: food_item, cart_item: @cart_item) if food_item.present?
        end
      end
    end
  
    if @cart_item && @cart.save
      render json: { message: 'Item added to cart successfully' }
    else
      render json: { error: 'Failed to add item to cart' }, status: :unprocessable_entity
    end
  end

  def remove_from_cart
    @cart = current_cart
    @cart_item = @cart.cart_items.find(params[:id])
    @cart_item.destroy
    redirect_to @restaurant
  end

  def clear_cart
    @cart = current_cart
    @cart.cart_items.destroy_all
    redirect_to @restaurant
  end

  private

  def set_restaurant 
    @restaurant = Restaurant.friendly.find(params[:restaurant_id])
  end

  def update_cart_activity(cart)
    cart.update(last_active_at: Time.current) if cart.persisted?
  end
end