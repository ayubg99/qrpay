class ApplicationController < ActionController::Base
  helper_method :current_cart

  def current_cart
    @current_cart ||= Cart.find_by(session_id: session[:cart_id])
  end
end
