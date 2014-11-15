class LocationsController < ApplicationController
  before_action :set_location, only: [:show, :edit, :update, :destroy]

  def index
    @locations = Location.all.publicly_viewable
    @hash = Gmaps4rails.build_markers(@locations) do |location, marker|
      marker.lat location.latitude
      marker.lng location.longitude
      marker.title location.name
    end
  end

  def show
    @hash = Gmaps4rails.build_markers(@location) do |location, marker|
      marker.lat location.latitude
      marker.lng location.longitude
      marker.title location.name
    end
  end

  def new
    @location = Location.new
    @location.build_submission
  end

  def create
    @location = Location.new(new_location_params)
    @submission = @location.build_submission(submission_params)
    
    if @location.save && @submission.save
      redirect_to root_path, notice: 'Location successfully submitted.'
    else
      flash[:error] = "Location submission failed. Please try again."
      render :new
    end
  end

  def edit
  end

  def update
    if @location.update(current_location_params) 
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

  def submission_params
    params.require(:submission).permit(:email)
  end

  def new_location_params
    params.require(:location).permit(:name, :description, :url, :address, :city, :state, :zipcode, :flagged, :category_ids => [])
  end

  def current_location_params
    params.require(:location).permit(:name, :description, :url, :address, :city, :state, :zipcode, :public, :flagged, :category_ids => [])
  end
end
