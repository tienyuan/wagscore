require 'rails_helper'

RSpec.describe Location, :type => :model do 

  describe "publicly_viewable scope" do
    before do
      @public_location = create(:location, public: true)
      @private_location = create(:location)
    end

    it "returns a relation of all public locations" do
      expect(Location.publicly_viewable).to eq( [@public_location] )
    end
  end

  describe "#full_address" do
    before do
      @location = create(:location, public: true)
    end

    it "returns a string with the address, city, state and zipcode" do
      expect(@location.full_address).to eq("#{@location.address}, #{@location.city}, #{@location.state}, #{@location.zipcode}")
    end
  end

  describe ".default_search_distance" do
    it "returns the default distance of 10 miles" do
      expect(Location.default_search_distance).to eq(10)
    end
  end

  describe ".search(search_term:, distance_term:, include_private:)" do
    before do
      @public_location = create(:location, public: true)
      @private_location = create(:location)
    end

    it "returns all locations when include_private is true" do
      expect(Location.search(search_term: nil, distance_term: nil, include_private: true)).to contain_exactly(@public_location, @private_location)
    end

    it "returns nearby locations when search_term and distance_term is present" do
      expect(Location.search(search_term: @public_location.full_address, distance_term: 10, include_private: nil)).to contain_exactly(@public_location)
    end

    it "returns all locations near a search_term when include_private is true" do
      expect(Location.search(search_term: @public_location.full_address, distance_term: 10, include_private: true)).to contain_exactly(@public_location, @private_location)
    end
  end  

  describe "ActiveModel validations" do
    before do
      @location = create(:location)
    end

    it { expect(@location).to validate_presence_of(:name).with_message( /can't be blank/ ) }
    it { expect(@location).to validate_presence_of(:address).with_message( /can't be blank/ ) }
    xit { expect(@location).to validate_presence_of(:categories).with_message( /can't be blank/ ) }
  end

  describe "ActiveRecord associations" do
    before do
      @location = create(:location)
    end
    
    it { expect(@location).to have_many(:categorizations) }
    it { expect(@location).to have_many(:categories) }
    it { expect(@location).to have_one(:submission) }    
  end
end
