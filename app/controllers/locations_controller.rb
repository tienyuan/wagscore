class LocationsController < ApplicationController
  before_action :set_location, only: [:show, :edit, :update, :destroy]

  def index
    if params[:search_location].present?
      @locations = Location.near(params[:search_location], params[:distance] || 10).publicly_viewable
    else
      @locations = Location.all.publicly_viewable
    end
   
    if !@locations.empty?
      @hash = Gmaps4rails.build_markers(@locations) do |location, marker|
        marker.lat location.latitude
        marker.lng location.longitude
        marker.title location.name
      end
    elsif params[:search_location].present? && @locations.empty?
      flash[:error] = 'No locations found. Please try again.'
      redirect_to root_path
    end
  end

  def show
    @nearby_locations = @location.nearbys(10)
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
    @location = Location.new(location_params)
    @location.build_submission(submission_params)
    @location.submission.ip_address = request.remote_ip

    if @location.save
      redirect_to root_path, notice: 'Location successfully submitted.'
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

  def submission_params
    params.require(:submission).permit(:email)
  end

  def location_params
    params.require(:location).permit(:name, :description, :url, :address, :city, :state, :zipcode, :public, :flagged, :category_ids => [])
  end
end
