require 'rails_helper'

feature "Admin creates a category", :type => :feature do

  scenario "with valid info" do
    category = create(:category)
    set_auth
    admin = create(:user, admin: true)
    login_as(admin, :scope => :user)

    visit root_path
    click_link "Manage Categories"
    expect(page).to have_content("Categories")
    click_link "New Category"

    fill_in 'Name', with: "Dog Vet"
    within 'form' do
      click_button 'Create Category'
    end

    last_category = Category.last
    expect(current_path).to eq(categories_path)
    expect(page).to have_content('Category was successfully created.')
    expect(last_category.name).to eq('Dog Vet')
  end
end