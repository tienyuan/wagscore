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
      category_1 = create(:category, name: 'one')
      category_2 = create(:category, name: 'two')
      category_3 = create(:category, name: 'three')
      category_4 = create(:category, name: 'four')
      location_1 = create(:location)
      location_2 = create(:location)
      location_3 = create(:location)
      categorization = create(:categorization, category: category_1, location: location_1)
      categorization = create(:categorization, category: category_2, location: location_2)
      categorization = create(:categorization, category: category_3, location: location_3)
      categorization = create(:categorization, category: category_4, location: location_3)
      @collection_1 = [location_1, location_2]
      @collection_2 = [location_2, location_3]
      @collection_3 = [location_1, location_2, location_3]
    end
    
    it "calculates a score given a list of locations" do
      expect(Score.calculate(@collection_1)).to eq("50%")
      expect(Score.calculate(@collection_2)).to eq("75%")
      expect(Score.calculate(@collection_3)).to eq("100%")
    end
  end
end