require 'rails_helper'

feature 'Visitor creates a location', type: :feature do

  scenario 'with valid info' do
    category = create(:category, name: 'Category')

    visit root_path
    click_link 'Submit a Location'
    expect(page).to have_content('Submit a Location')

    fill_in 'Name', with: 'Dog Vet'
    fill_in 'Description', with: 'We treat dogs'
    fill_in 'Url', with: 'vet.com'
    fill_in 'Address', with: '123 Main Street'
    fill_in 'City', with: 'Metropolis'
    fill_in 'State', with: 'CA'
    fill_in 'Zipcode', with: '12345'
    check 'Category'
    fill_in 'Email', with: 'test@email.com'
    within 'form' do
      click_button 'Create Location'
    end

    last_location = Location.last
    last_submission = Submission.last
    expect(current_path).to eq(root_path)
    expect(page).to have_content('Location successfully submitted.')
    expect(last_location.name).to eq('Dog Vet')
    expect(last_location.description).to eq('We treat dogs')
    expect(last_location.url).to eq('vet.com')
    expect(last_location.address).to eq('123 Main Street')
    expect(last_location.city).to eq('Metropolis')
    expect(last_location.state).to eq('CA')
    expect(last_location.zipcode).to eq('12345')
    expect(last_location.categories).to eq([category])
    expect(last_location.public).to eq false
    expect(last_location.submission).to eq(last_submission)
    expect(last_submission.ip_address). to eq('127.0.0.1')
    expect(last_submission.email). to eq('test@email.com')
    expect(last_submission.location). to eq(last_location)
  end
end
