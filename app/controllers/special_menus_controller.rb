class SpecialMenusController < ApplicationController
  before_action :authenticate_restaurant!
  before_action :set_special_menu, only: %i[ show edit update destroy ]
  before_action :set_restaurant

  def new
    @special_menu = @restaurant.special_menus.build
  end

  def edit
  end

  def create
    @special_menu = @restaurant.special_menus.build(special_menu_params)

    respond_to do |format|
      if @special_menu.save
        format.html { redirect_to restaurant_dashboard_special_menus_path(@restaurant), notice: "Special menu was successfully created." }
        format.json { render :show, status: :created, location: @special_menu }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @special_menu.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @special_menu.update(special_menu_params)
        format.html { redirect_to restaurant_dashboard_special_menus_path(@restaurant), notice: "Special menu was successfully updated." }
        format.json { render :show, status: :ok, location: @special_menu }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @special_menu.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @special_menu.soft_delete

    respond_to do |format|
      format.html { redirect_to restaurant_dashboard_special_menus_path(@restaurant), notice: "Special menu was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_special_menu
      @special_menu = SpecialMenu.find(params[:id])
    end

    def set_restaurant 
      @restaurant = Restaurant.friendly.find(params[:restaurant_id])
    end

    # Only allow a list of trusted parameters through.
    def special_menu_params
      params.require(:special_menu).permit(:name, :restaurant_id, :description, :price, :instructions, :minimum_persons, :start_hour, :end_hour, food_item_ids: [])
    end
end
