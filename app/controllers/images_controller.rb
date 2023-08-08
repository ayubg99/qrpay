class ImagesController < ApplicationController
    before_action :set_restaurant
    before_action :set_special_menu
    before_action :set_image, only: [:show, :destroy]
  
    def new
      @image = Image.new
    end
  
    def create
      @image = @special_menu.images.build(image_params)
      if @image.save
        redirect_to restaurant_dashboard_special_menus_path(@restaurant), notice: 'Image was successfully uploaded.'
      else
        render :new
      end
    end
  
    def show
    end
  
    def destroy
      @image.destroy
      redirect_to restaurant_dashboard_special_menus_path(@restaurant), notice: 'Image was successfully deleted.'
    end
  
    private
    
    def set_restaurant 
        @restaurant = Restaurant.friendly.find(params[:restaurant_id])
    end

    def set_special_menu
      @special_menu = SpecialMenu.find(params[:special_menu_id])
    end
  
    def set_image
      @image = @special_menu.images.find(params[:id])
    end
  
    def image_params
      params.require(:image).permit(:image)
    end
end  