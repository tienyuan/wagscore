require 'rails_helper'

describe CategoryPolicy do
  subject { described_class }

  before do
    @user = create(:user)
    @admin = create(:user, admin: true)
    @category = create(:category)
  end

  permissions :index? do
    it "denies access if user is not an admin" do
      expect(subject).not_to permit(@user, @category)
    end

    it "grants access if user is admin" do
      expect(subject).to permit(@admin, @category)
    end
  end

  permissions :create? do
    it "denies access if user is not an admin" do
      expect(subject).not_to permit(@user, @category)
    end

    it "grants access if user is admin" do
      expect(subject).to permit(@admin, @category)
    end
  end

  permissions :update? do
    it "denies access if user is not an admin" do
      expect(subject).not_to permit(@user, @category)
    end

    it "grants access if user is admin" do
      expect(subject).to permit(@admin, @category)
    end
  end
end