require 'rails_helper'

RSpec.describe Submission, :type => :model do

  before do
      @submission = create(:submission)
    end

  describe "ActiveModel validations" do
    it { expect(@submission).to validate_presence_of(:ip_address).with_message( /can't be blank/ ) }
    it { expect(@submission).to validate_presence_of(:email).with_message( /can't be blank/ ) }
  end

  describe "ActiveRecord associations" do
    it { expect(@submission).to belong_to(:location) }    
  end
end
