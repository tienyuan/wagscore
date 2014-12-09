require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'class methods' do
    before do
      @user = create(:user)
    end

    describe 'ActiveModel validations' do
      it { expect(@user).to validate_presence_of(:username).with_message(/can't be blank/) }
      it { expect(@user).to validate_uniqueness_of(:username) }
    end
  end
end
