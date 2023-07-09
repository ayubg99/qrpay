class ApplicationController < ActionController::Base
  helper_method :current_cart
  before_action :set_restaurant
  before_action :ensure_session_id

  def current_cart
    @current_cart ||= Cart.find_or_create_by(restaurant_id: @restaurant.id, session_id: session[:cart_id])
  end

  private
  def set_restaurant
    @restaurant = Restaurant.friendly.find(params[:id]) if @restaurant
  end

  def ensure_session_id
    session[:cart_id] ||= generate_session_id
  end

  def generate_session_id
    SecureRandom.hex(16)
  end
end
