class LocationsController < ApplicationController
  respond_to :html, :js
  before_action :set_location, only: [:show, :edit, :update, :destroy]

  def index
    if params[:search_location].present?
      @locations = Location.near(params[:search_location], params[:distance] || 10).publicly_viewable
    elsif current_user
      if current_user.admin && params[:search_location].present?
        @locations = Location.near(params[:search_location], params[:distance] || 10)
      elsif current_user.admin
        @locations = Location.all
      end
    else
      @locations = Location.all.publicly_viewable
    end
   
    if @locations.present?
      @hash = Gmaps4rails.build_markers(@locations) do |location, marker|
        marker.lat location.latitude
        marker.lng location.longitude
        marker.title location.name
      end
    elsif params[:search_location].present? && @locations.blank?
      flash[:error] = 'No locations found. Please try again.'
      redirect_to root_path
    end
  end

  def show
    authorize @location
    @nearby_locations = @location.nearbys(10)
    @hash = Gmaps4rails.build_markers(@location) do |location, marker|
      marker.lat location.latitude
      marker.lng location.longitude
      marker.title location.name
    end
  end

  def new
    @location = Location.new
    authorize @location
    @location.build_submission
  end

  def create
    @location = Location.new(location_params)
    authorize @location
    @location.build_submission(submission_params)
    @location.submission.ip_address = request.remote_ip

    if @location.save
      redirect_to root_path, notice: 'Location successfully submitted. We will review and post it soon!'
    else
      flash[:error] = "Location submission failed. Please try again."
      render :new
    end
  end

  def edit
    authorize @location
  end

  def update
    authorize @location
    if @location.update(location_params) 
      redirect_to @location, notice: 'Location was successfully updated.'
    else
      flash[:error] = "Location edit failed. Please try again."
      render :edit 
    end
  end

  def flag_location
    @location = Location.find(params[:location_id])
    authorize @location
    if @location.update_attributes!(flagged: true)
      respond_with(@location) do |format|
        format.json { redirect_to @location }
      end 
    end
  end

  def destroy
    authorize @location
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
