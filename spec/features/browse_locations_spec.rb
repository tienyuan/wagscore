require 'rails_helper'

feature "Visitor goes to list", :type => :feature do

  before do
    #allow_any_instance_of(Location).to receive(:geocode).and_return([1,1])
    Geocoder.configure(:lookup => :test)
    Geocoder::Lookup::Test.set_default_stub(
  [
    {
      'latitude'     => 40.7143528,
      'longitude'    => -74.0059731,
      'address'      => 'New York, NY, USA',
      'state'        => 'New York',
      'state_code'   => 'NY',
      'country'      => 'United States',
      'country_code' => 'US'
    }
  ]
)
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

  xscenario "as a visitor, searches for public locations near a place" do
    @other_location = create(:location, latitude: '20', longitude: '20', public: true)
    
    visit root_path
    fill_in 'search_location', with: "455 N Rexford Dr, Beverly Hills, 90210"
    within 'form' do
      click_button 'Search'
    end
    puts page.body
    expect(page).to have_content(@public_location.name)
    expect(page).not_to have_content(@other_location.name)
  end
end