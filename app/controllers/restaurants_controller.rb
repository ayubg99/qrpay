class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: %i[ show ]
  
  def show
    @categories = @restaurant.categories
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_restaurant
      @restaurant = Restaurant.friendly.find(params[:id])
    end
end