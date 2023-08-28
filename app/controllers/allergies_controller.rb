class AllergiesController < ApplicationController
    before_action :set_allergy, only: [:edit, :update, :destroy]
    before_action :authenticate_admin!
  
    def new
      @allergy = Allergy.new
    end
  
    def create
      @allergy = Allergy.new(allergy_params)
      if @allergy.save
        redirect_to admin_dashboard_path, notice: 'Allergy was successfully created.'
      else
        render :new
      end
    end
  
    def edit
    end
  
    def update
      if @allergy.update(allergy_params)
        redirect_to allergies_path, notice: 'Allergy was successfully updated.'
      else
        render :edit
      end
    end
  
    def destroy
      @allergy.destroy
      redirect_to allergies_path, notice: 'Allergy was successfully deleted.'
    end
  
    private
  
    def set_allergy
      @allergy = Allergy.find(params[:id])
    end
  
    def allergy_params
      params.require(:allergy).permit(:name, :color)
    end
  end