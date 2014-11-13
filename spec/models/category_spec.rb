require 'rails_helper'

RSpec.describe Category do
  describe "ActiveModel validations" do
    before do
      @category = create(:category)
    end

    it { expect(@category).to validate_presence_of(:name).with_message( /can't be blank/ ) }
  end
end
