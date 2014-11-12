class LocationsController < ApplicationController
  before_action :set_location, only: [:show, :edit, :update, :destroy]

  def index
    @locations = Location.all.publicly_viewable
  end

  def show
  end

  def new
    @location = Location.new
  end

  def create
    @location = Location.new(location_params)

    if @location.save
      redirect_to @location, notice: 'Location successfully submitted.'
    else
      flash[:error] = "Location submission failed. Please try again."
      render :new
    end
  end

  def edit
  end

  def update
    if @location.update(location_params)
      redirect_to @location, notice: 'Location was successfully updated.'
    else
      flash[:error] = "Location edit failed. Please try again."
      render :edit 
    end
  end

  def destroy
    @location.destroy
    redirect_to locations_url, notice: 'Location was successfully deleted.'
  end

  private
    def set_location
      @location = Location.find(params[:id])
    end

    def location_params
      params.require(:location).permit(:name, :description, :url, :address, :city, :state, :zipcode, :public, :flagged)
    end
end
