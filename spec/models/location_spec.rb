require 'rails_helper'

RSpec.describe Location do 

  before do
    allow_any_instance_of(Location).to receive(:geocode).and_return([1,1]) 
  end

  describe "publicly_viewable" do
    before do
      @public_location = create(:location, public: true)
      @private_location = create(:location)
    end

    it "returns a relation of all public locations" do
      expect(Location.publicly_viewable).to eq( [@public_location] )
    end
  end

  describe "ActiveModel validations" do
    before do
      @location = create(:location)
    end

    it { expect(@location).to validate_presence_of(:name).with_message( /can't be blank/ ) }
    it { expect(@location).to validate_presence_of(:address).with_message( /can't be blank/ ) }
  end
end
