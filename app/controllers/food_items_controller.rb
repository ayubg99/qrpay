class FoodItemsController < ApplicationController
  before_action :set_food_item, only: %i[ show edit update destroy ]
  before_action :set_restaurant

  def index
    @food_items = FoodItem.all
  end

  def show
  end

  def new
    @food_item = FoodItem.new
  end

  def edit
  end

  def create
    @food_item = FoodItem.new(food_item_params)
    @food_item.restaurant_id = @restaurant.id

    respond_to do |format|
      if @food_item.save
        format.html { redirect_to @restaurant, notice: "Food item was successfully created." }
        format.json { render :show, status: :created, location: @food_item }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @food_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @food_item.update(food_item_params)
        format.html { redirect_to @restaurant, notice: "Food item was successfully updated." }
        format.json { render :show, status: :ok, location: @food_item }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @food_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @food_item.destroy

    respond_to do |format|
      format.html { redirect_to @restaurant, notice: "Food item was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_food_item
      @food_item = FoodItem.find(params[:id])
    end

    def set_restaurant 
      @restaurant = Restaurant.friendly.find(params[:restaurant_id])
    end

    # Only allow a list of trusted parameters through.
    def food_item_params
      params.require(:food_item).permit(:name, :description, :price, :image, :restaurant_id, :category_id)
    end
end
