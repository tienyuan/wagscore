require 'rails_helper'

feature "Visitor goes to list", :type => :feature do

  before do
    allow_any_instance_of(Location).to receive(:geocode).and_return([1,1])
    @public_location = create(:location, public: true)
    @private_location = create(:location)
  end

  scenario "as a visitor, sees public locations" do
    
    visit root_path
    expect(page).to have_content(@public_location.name)
    expect(page).to have_content(@public_location.description)
    expect(page).not_to have_content(@private_location.name)
    expect(page).not_to have_content(@private_location.description)

    click_link "#{@public_location.name}"
    expect(page).to have_content(@public_location.description)
    expect(page).to have_content(@public_location.url)
    expect(page).to have_content(@public_location.address)
    expect(page).to have_content(@public_location.state)
    expect(page).to have_content(@public_location.zipcode)
    expect(page).not_to have_content(@public_location.public)
    expect(page).not_to have_content(@public_location.flagged)
    expect(page).not_to have_content(@public_location.latitude)
    expect(page).not_to have_content(@public_location.longitude)
  end
end