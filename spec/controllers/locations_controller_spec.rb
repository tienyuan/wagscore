require 'rails_helper'

RSpec.describe LocationsController, :type => :controller do

  include Devise::TestHelpers

  before do
    allow_any_instance_of(Location).to receive(:geocode).and_return([1,1]) 
  end

  describe "#index" do
    render_views

    it "shows only public locations" do
      public_location = create(:location, public: true)
      private_location = create(:location)

      get :index
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:index)
      expect(Location.count).to eq(2)
      expect(response.body).to include public_location.name 
      expect(response.body).to include public_location.description
      expect(response.body).not_to include private_location.name 
      expect(response.body).not_to include private_location.description 
    end

    it "shows only public locations near a search location" do
      public_location = create(:location, public: true)
      private_location = create(:location)

      params = {search_location: '455 N Rexford Dr, Beverly Hills', distance: '1'} 
      get :index, params
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:index)
      expect(Location.count).to eq(2)
      expect(response.body).to include public_location.name 
      expect(response.body).to include public_location.description
      expect(response.body).not_to include private_location.name 
      expect(response.body).not_to include private_location.description 
    end
  end

  describe "#show" do
    render_views

    it "shows a valid location and nearby locations" do
      location = create(:location, public: true)
      near_location = create(:location, public: true)
      far_location = create(:location, latitude: '20', longitude: "20", public: true)

      get :show, {id: location.id}
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:show)
      expect(response.body).to include location.name
      expect(response.body).to include location.description
      expect(response.body).to include location.url
      expect(response.body).to include location.address
      expect(response.body).to include location.city
      expect(response.body).to include location.state
      expect(response.body).to include location.zipcode
      expect(response.body).to include near_location.name
      expect(response.body).not_to include far_location.name
    end
  end

  describe "#new" do
    it "shows a new location form" do
      get :new

      expect(response).to have_http_status(:success)
      expect(response).to render_template(:new)     
    end
  end

  describe "#create" do
    it "creates a new location with valid info" do
      params = {location: {name: 'name', description: 'description', address: 'address', url: 'url', city: 'city', state: 'state', zipcode: '12345'}, submission: {email: 'test@email.com', ip_address: '0.0.0.0'}}
      post :create, params

      expect(response).to be_redirect
      expect(Location.last.name).to eq('name')
      expect(flash[:notice]).to eq "Location successfully submitted."
    end
  
    it "fails with a blank name" do
      params = {location: {name: '', description: 'description', address: 'address', url: 'url', city: 'city', state: 'state', zipcode: '12345'}, submission: {email: 'test@email.com', ip_address: '0.0.0.0'}}
      post :create, params

      expect(response).to have_http_status(:success)
      expect(flash[:error]).to eq "Location submission failed. Please try again."
    end

    it "fails with a blank address" do
      params = {location: {name: 'name', description: 'description', address: '', url: 'url', city: 'city', state: 'state', zipcode: '12345'}, submission: {email: 'test@email.com', ip_address: '0.0.0.0'}}
      post :create, params

      expect(response).to have_http_status(:success)
      expect(flash[:error]).to eq "Location submission failed. Please try again."
    end

    it "fails with a blank email" do
      params = {location: {name: 'name', description: 'description', address: 'address', url: 'url', city: 'city', state: 'state', zipcode: '12345'}, submission: {email: '', ip_address: '0.0.0.0'}}
      post :create, params

      expect(response).to have_http_status(:success)
      expect(flash[:error]).to eq "Location submission failed. Please try again."
    end
  end

  describe "#edit" do
    render_views

    it "shows location edit form", focus: true do
      location = create(:location)
      submission = create(:submission, location: location)
      get :edit, {id: location.id}

      expect(response).to have_http_status(:success)
      expect(response).to render_template(:edit)
      expect(response.body).to include location.latitude.to_s
      expect(response.body).to include location.longitude.to_s
      expect(response.body).to include location.submission.email
      expect(response.body).to include location.submission.ip_address
    end
  end

  describe "#update" do
    before do
      @location = create(:location, name: 'old name')
    end

    it "updates with valid info" do
      expect(@location.name).to eq('old name')
      patch :update, id: @location.id, location:{name: 'new name'}
      @location.reload

      expect(response).to be_redirect
      expect(@location.name).to eq('new name')
    end

    it "fails without a name" do
      invalid_name = ""
      patch :update, id: @location.id, location:{name: invalid_name}

      expect(response).to have_http_status(:success)
      expect(flash[:error]).to eq "Location edit failed. Please try again."
    end

    it "fails without an address" do
      invalid_address = ""
      patch :update, id: @location.id, location:{address: invalid_address}

      expect(response).to have_http_status(:success)
      expect(flash[:error]).to eq "Location edit failed. Please try again."
    end
  end

  describe "#destroy" do
    it "destroys the requested location" do
      location = create(:location)
      delete :destroy, id: location.id

      expect(response).to be_redirect
      expect(flash[:notice]).to eq "Location was successfully deleted."
      expect(Location.count).to eq(0)
    end
  end
end
