require 'rails_helper'

describe LocationPolicy do
  subject { described_class }

  before do
    @user = create(:user)
    @admin = create(:user, admin: true)
    @public_location = create(:location, public: true)
    @private_location = create(:location)
  end

  permissions :update? do
    xit "denies access if user is not an admin" do
      expect(subject).not_to permit(@user, @public_location)
      expect(subject).not_to permit(@user, @private_location)      
    end

    #currently update is used by flagging and updating using the edit form. Anyone can flag but only the admin should edit.

    it "grants access to public and private locations if user is admin" do
      expect(subject).to permit(@admin, @public_location)
      expect(subject).to permit(@admin, @private_location)
    end
  end

  permissions :destroy? do
    it "denies access if user is not an admin" do
      expect(subject).not_to permit(@user, @public_location)
      expect(subject).not_to permit(@user, @private_location)      
    end

    it "grants access to public and private locations if user is admin" do
      expect(subject).to permit(@admin, @public_location)
      expect(subject).to permit(@admin, @private_location)
    end
  end

end