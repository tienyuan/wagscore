require 'rails_helper'

feature "Admin edits a category", :type => :feature do

  before do
    @admin = create(:user, admin: true)
    @category = create(:category)
  end

  scenario "edit location with valid info" do
    signs_in_with(@admin.email, @admin.password)

    visit root_path
    click_link "Manage Categories"
    click_link "Edit"
    fill_in 'Name', with: "Dog Vet"
    within 'form' do
      click_button 'Update Category'
    end
    
    last_category = Category.last
    expect(current_path).to eq(categories_path)
    expect(page).to have_content('Category was successfully updated.')
    expect(last_category.name).to eq('Dog Vet')
  end

  scenario "deletes category" do
    signs_in_with(@admin.email, @admin.password)

    visit root_path
    click_link "Manage Categories"
    click_link "Destroy"
    
    expect(current_path).to eq(categories_path)
    expect(page).to have_content('Category was successfully deleted.')
    expect(Category.count).to eq(0)
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