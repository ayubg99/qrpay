class TablesController < ApplicationController
  before_action :authenticate_restaurant!
  before_action :set_table, only: %i[ edit update destroy download_qr_code ]
  before_action :set_restaurant

  def new
    @table = Table.new
  end

  def edit
  end

  def create
    @table = Table.new(table_params)
    @table.restaurant_id = @restaurant.id

    respond_to do |format|
      if @table.save
        format.html { redirect_to restaurant_dashboard_tables_path(@restaurant), notice: "Table was successfully created." }
        format.json { render :show, status: :created, location: @table }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @table.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @table.update(table_params)
        format.html { redirect_to restaurant_dashboard_tables_path(@restaurant), notice: "Table was successfully updated." }
        format.json { render :show, status: :ok, location: @table }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @table.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @table.destroy

    respond_to do |format|
      format.html { redirect_to restaurant_dashboard_tables_path(@restaurant), notice: "Table was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def download_qr_code
    qr_code = @table.qrcode
    respond_to do |format|
      format.html {
        redirect_to @restaurant
      }
      format.png {
        redirect_to rails_blob_path(qr_code, disposition: 'attachment')
      }
    end
  end

  private
    def set_table
      @table = Table.find(params[:id])
    end

    def set_restaurant 
      @restaurant = Restaurant.friendly.find(params[:restaurant_id])
    end

    def table_params
      params.require(:table).permit(:table_number, :restaurant_id, :qrcode)
    end
end