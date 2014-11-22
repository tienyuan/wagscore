require 'rails_helper'

RSpec.describe Category, :type => :model do
  
  describe "ActiveModel validations" do
    before do
      @category = create(:category)
    end

    it { expect(@category).to validate_presence_of(:name).with_message( /can't be blank/ ) }
    it { expect(@category).to validate_uniqueness_of(:name) }
  end

  describe "ActiveRecord associations" do
    before do
      @category = create(:category)
    end
    
    it { expect(@category).to have_many(:categorizations) }
    it { expect(@category).to have_many(:locations) }
  end
end
