class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_cart
  before_action :ensure_session_id
  
  def current_cart
    @current_cart ||= Cart.find_or_create_by(restaurant_id: @restaurant.id, session_id: session[:cart_id])
  end

  private
  def ensure_session_id
    session[:cart_id] ||= generate_session_id
  end

  def generate_session_id
    SecureRandom.hex(16)
  end

  def check_restaurant_authorization
    unless current_restaurant == @restaurant || current_admin
      redirect_to root_path, alert: "Access denied."
    end
  end

  def authenticate_restaurant_if_no_admin
    authenticate_restaurant! unless current_admin
  end
end
