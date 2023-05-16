class CategoriesController < ApplicationController
    before_action :set_restaurant
    
    def new
      @category = Category.new
    end
  
    def create
      @category = @restaurant.categories.build(category_params)
      if @category.save
        redirect_to @restaurant, notice: 'Category created successfully'
      else
        render :new
      end
    end
  
    private

    def set_restaurant 
        @restaurant = Restaurant.friendly.find(params[:restaurant_id])
    end
  
    def category_params
      params.require(:category).permit(:name)
    end
  end