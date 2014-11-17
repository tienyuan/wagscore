require 'rails_helper'

feature "Admin edits a location", :type => :feature do

  before do
    allow_any_instance_of(Location).to receive(:geocode).and_return([1,1])
    @user = create(:user, admin: true)
    @location = create(:location, public: true)
    @submission = create(:submission, location: @location)
  end

  scenario "edit location with valid info" do
    signs_in_with(@user.email, @user.password)

    visit root_path
    click_link "#{@location.name}"
    click_link "Edit"
    fill_in 'Name', with: "Dog Vet"
    fill_in 'Description', with: "We treat dogs"
    fill_in 'Url', with: "vet.com"
    fill_in 'Address', with: "123 Main Street"
    fill_in 'City', with: "Metropolis"
    fill_in 'State', with: "CA"
    fill_in 'Zipcode', with: "12345"
    check 'Flagged'
    within 'form' do
      click_button 'Update Location'
    end
    
    expect(current_path).to eq(location_path(@location))
    expect(page).to have_content('Location was successfully updated.')
    expect(Location.last.name).to eq('Dog Vet')
    expect(Location.last.description).to eq('We treat dogs')
    expect(Location.last.url).to eq('vet.com')
    expect(Location.last.address).to eq('123 Main Street')
    expect(Location.last.city).to eq('Metropolis')
    expect(Location.last.state).to eq('CA')
    expect(Location.last.zipcode).to eq('12345')
    expect(Location.last.flagged).to eq true
  end

  scenario "deletes location with valid info" do
    signs_in_with(@user.email, @user.password)

    visit root_path
    click_link "#{@location.name}"
    click_link "Destroy"
    
    expect(current_path).to eq(locations_path)
    expect(page).to have_content('Location was successfully deleted.')
    expect(Location.count).to eq(0)
  end

  private

  def signs_in_with(email, password)
    visit new_user_session_path
    fill_in 'Email', with: email
    fill_in 'Password', with: password
    within 'form' do
      click_button 'Sign in'
    end
  end

end