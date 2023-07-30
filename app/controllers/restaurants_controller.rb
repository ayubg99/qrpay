class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: %i[ show ]
  
  def show
    @categories = @restaurant.categories
    @food_items = []
    
    @restaurant.categories.each do |category|
      @food_items.concat(category.food_items)
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_restaurant
      @restaurant = Restaurant.friendly.find(params[:id])
    end
end