require 'rails_helper'

feature "Visitor creates a location", :type => :feature do

  before do
    allow_any_instance_of(Location).to receive(:geocode).and_return([1,1])
  end

  scenario "with valid info" do
    visit root_path
    click_link "Submit a Location"
    expect(page).to have_content("Submit a Location")

    fill_in 'Name', with: "Dog Vet"
    fill_in 'Description', with: "We treat dogs"
    fill_in 'Url', with: "vet.com"
    fill_in 'Address', with: "123 Main Street"
    fill_in 'City', with: "Metropolis"
    fill_in 'State', with: "CA"
    fill_in 'Zipcode', with: "12345"
    fill_in 'Email', with: "test@email.com"
    within 'form' do
      click_button 'Create Location'
    end

    # expect(current_path).to eq(root_path)      
    expect(page).to have_content('Location successfully submitted.')
    expect(Location.last.name).to eq('Dog Vet')
    expect(Location.last.description).to eq('We treat dogs')
    expect(Location.last.url).to eq('vet.com')
    expect(Location.last.address).to eq('123 Main Street')
    expect(Location.last.city).to eq('Metropolis')
    expect(Location.last.state).to eq('CA')
    expect(Location.last.zipcode).to eq('12345')
    expect(Location.last.public).to eq false
    # expect(Submission.last.ip_address). to eq()
    expect(Submission.last.email). to eq('test@email.com')
    expect(Submission.last.location). to eq(Location.last)
  end
end