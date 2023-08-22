class FoodTypesController < ApplicationController
  before_action :authenticate_restaurant!
  before_action :set_food_type, only: %i[ show edit update destroy ]
  before_action :set_special_menu
  before_action :set_restaurant

  def show
  end

  def new
    @food_type = @special_menu.food_types.build
    @food_type.food_type_food_items.build
  end

  def edit
  end

  def create
    @food_type = @special_menu.food_types.build(food_type_params)

    respond_to do |format|
      if @food_type.save
        format.html { redirect_to restaurant_dashboard_special_menus_path(@restaurant), notice: "Food type was successfully created." }
        format.json { render :show, status: :created, location: @food_type }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @food_type.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @food_type.update(food_type_params)
        format.html { redirect_to restaurant_dashboard_special_menus_path(@restaurant), notice: "Food type was successfully updated." }
        format.json { render :show, status: :ok, location: @food_type }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @food_type.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @food_type.destroy

    respond_to do |format|
      format.html { redirect_to restaurant_dashboard_special_menus_path(@restaurant), notice: "Food type was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_food_type
      @food_type = FoodType.find(params[:id])
    end

    def set_special_menu
      @special_menu = SpecialMenu.find(params[:special_menu_id])
    end

    def set_restaurant 
      @restaurant = Restaurant.friendly.find(params[:restaurant_id])
    end

    # Only allow a list of trusted parameters through.
    def food_type_params
      params.require(:food_type).permit(:name, :description, :special_menu_id, :have_to_select_one, food_item_ids: [])
    end
end
