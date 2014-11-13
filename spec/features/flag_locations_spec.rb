require 'rails_helper'

feature "Visitor goes to a location", :type => :feature do

  before do
    allow_any_instance_of(Location).to receive(:geocode).and_return([1,1])
    @location = create(:location, public: true)
  end

  scenario "flags location for review" do
    visit root_path
    click_link "#{@location.name}"
    expect(page).to have_content("Flag")
    expect(@location.flagged).to be false

    click_link "Flag"
    @location.reload
    expect(page).to have_content("Flagged for review")
    expect(@location.flagged).to be true
  end
end