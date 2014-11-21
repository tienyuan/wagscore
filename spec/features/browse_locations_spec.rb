require 'rails_helper'

feature "Visitor goes to list", :type => :feature do

  before do
    @public_location = create(:location, public: true)
    @private_location = create(:location)
    @other_location = create(:location, public: true)
  end

  scenario "as a visitor, sees public locations" do
    visit root_path
    expect(page).to have_content(@public_location.name)
    expect(page).to have_content(@public_location.description)
    expect(page).not_to have_content(@private_location.name)
    expect(page).not_to have_content(@private_location.description)
    expect(page).to have_content("WagScore #{score}")

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

  scenario "as a visitor, searches for public locations near a place" do
    visit root_path
    fill_in 'search_location', with: "455 N Rexford Dr, Beverly Hills, 90210"
    select('1 mi', :from => 'distance')
    within 'form' do
      click_button 'Search'
    end
    
    expect(page).to have_content(@public_location.name)
    expect(page).to have_content(@other_location.name)
    expect(page).not_to have_content(@private_location.name)
  end
end