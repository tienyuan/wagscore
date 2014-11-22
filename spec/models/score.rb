require 'rails_helper'

RSpec.describe Score, :type => :model do 

  describe ".calculate_score(locations)" do

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
      expect([].calculate_score).to eq("0%")
      expect([@location_1, @location_2].calculate_score).to eq("50%")
      expect([@location_2, @location_3].calculate_score).to eq("75%")
      expect([@location_1, @location_2, @location_3].calculate_score).to eq("100%")
    end
  end
end