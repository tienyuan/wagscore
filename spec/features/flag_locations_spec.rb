require 'rails_helper'

feature 'Visitor goes to a location', type: :feature, js: true do

  scenario 'flags location for review' do
    location = create(:location, public: true)
    category = create(:category)
    create(:categorization, category: category, location: location)

    visit root_path
    click_link "#{location.name}"
    expect(page).to have_content('Flag')
    expect(location.flagged).to be false

    click_link 'Flag'
    expect(page).to have_content('Location flagged for review.')
    location.reload
    expect(location.flagged).to be true
  end
end
