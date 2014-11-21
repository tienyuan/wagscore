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

  describe ".search_and_show(search_term, distance_term, admin_view)" do
    before do
      @public_location = create(:location, public: true)
      @private_location = create(:location)
    end

    it "returns all locations when admin_view is true" do
      expect(Location.search_and_show(nil, nil, true)).to contain_exactly(@public_location, @private_location)
    end

    it "returns nearby locations when search_term and distance_term is present" do
      expect(Location.search_and_show(@public_location.full_address, 10, nil)).to contain_exactly(@public_location)
    end

    it "returns all locations near a search_term when admin_view is true" do
      expect(Location.search_and_show(@public_location.full_address, 10, true)).to contain_exactly(@public_location, @private_location)
    end
  end

  describe ".calculate_score" do

    #so it's best if the test works regardless of what categories are present
    #let's say the ideal area has one of each category
    #there are 4 categories: park, vet, store, groomer
    #so each category is worth 25%
    #i'd want to count the number of unique categories present given a list of locations then 
    #and multiply by the value per category
    #remember, each location can have more than one category...

    before do
      @category_1 = create(:category)
      @category_2 = create(:category)
      @category_3 = create(:category)
      @category_4 = create(:category)
      @location_1 = create(:location)
      @location_2 = create(:location)
      @location_3 = create(:location)
      @categorization = create(:categorization, category: @category_1, location: @location_1)
      @categorization = create(:categorization, category: @category_2, location: @location_2)
      @categorization = create(:categorization, category: @category_3, location: @location_3)
      @categorization = create(:categorization, category: @category_4, location: @location_3)
    end
    
    it "calculates a score given a list of locations" do
      expect([@location_1, @location_2].calculate_score).to eq("50%")
      expect([@location_2, @location_3].calculate_score).to eq("75%")
      expect([@location_1, @location_2, @location_3].calculate_score).to eq("100%")
    end
  end

  describe "ActiveModel validations" do
    before do
      @location = create(:location)
    end

    it { expect(@location).to validate_presence_of(:name).with_message( /can't be blank/ ) }
    it { expect(@location).to validate_presence_of(:address).with_message( /can't be blank/ ) }
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
