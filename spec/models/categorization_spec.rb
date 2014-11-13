require 'rails_helper'

RSpec.describe Categorization do
  
  describe "class methods" do
    before do
      @categorization = create(:categorization)
    end

    describe "ActiveRecord associations" do
      it { expect(@categorization).to belong_to(:category) }
      it { expect(@categorization).to belong_to(:location) }
    end
  end
end
