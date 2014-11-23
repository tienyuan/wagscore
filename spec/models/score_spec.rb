require 'rails_helper'

RSpec.describe Score, :type => :model do 

  describe ".calculate(locations)" do

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
      @collection_1 = [location_1]
      @collection_2 = [location_1, location_2]
      @collection_3 = [location_3]
      @collection_4 = [location_2, location_3]
      @collection_5 = [location_1, location_2, location_3]
    end
    
    it "calculates a score given a list of locations" do
      expect(Score.calculate(nil)).to eq(0.0)
      expect(Score.calculate(@collection_1)).to eq(25)
      expect(Score.calculate(@collection_2)).to eq(50)
      expect(Score.calculate(@collection_3)).to eq(50)
      expect(Score.calculate(@collection_4)).to eq(75)
      expect(Score.calculate(@collection_5)).to eq(100)
    end
  end
end