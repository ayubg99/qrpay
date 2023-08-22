class CategoriesController < ApplicationController
  before_action :authenticate_restaurant!
  before_action :set_category, only: %i[ edit update destroy ]
  before_action :set_restaurant
    
  def new
    @category = Category.new
  end

  def edit
  end
  
  def create
    @category = @restaurant.categories.build(category_params)
    if @category.save
      redirect_to restaurant_dashboard_menu_path(@restaurant), notice: 'Category created successfully'
    else
      render :new
    end
  end

  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to restaurant_dashboard_menu_path(@restaurant), notice: "Category was successfully updated." }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @category.soft_delete
  
    respond_to do |format|
      format.html { redirect_to restaurant_dashboard_menu_path(@restaurant), notice: "Category was successfully destroyed." }
      format.json { head :no_content }
    end
  end
  
  private

    def set_category
      @category = Category.find(params[:id])
    end

    def set_restaurant 
        @restaurant = Restaurant.friendly.find(params[:restaurant_id])
    end
  
    def category_params
      params.require(:category).permit(:name)
    end
  end