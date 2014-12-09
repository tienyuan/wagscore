require 'rails_helper'

RSpec.describe Categorization, type: :model do

  describe 'ActiveModel validations' do
    before do
      @categorization = create(:categorization)
    end

    it { expect(@categorization).to validate_presence_of(:category).with_message(/can't be blank/) }
    it { expect(@categorization).to validate_presence_of(:location).with_message(/can't be blank/) }
  end

  describe 'ActiveRecord associations' do
    before do
      @categorization = create(:categorization)
    end

    it { expect(@categorization).to belong_to(:category) }
    it { expect(@categorization).to belong_to(:location) }
  end
end
