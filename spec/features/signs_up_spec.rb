require 'rails_helper'

feature "Visitor signs up", :type => :feature do

  include EmailSpec::Helpers
  include EmailSpec::Matchers

  before do
    reset_mailer
    set_auth
  end

  scenario "with valid email and password" do
    sign_up_with('new_email@example.com', 'new_username', 'password')

    click_email_confirmation_link('new_email@example.com')
    fill_in 'Email', with: "new_email@example.com"
    fill_in 'Password', with: "password"
    within 'form' do
      click_button 'Sign in'
    end

    expect(current_path).to eq root_path
  end

  scenario "with invalid email" do
    sign_up_with('new_email@example', 'new_username', 'password')

    expect(current_path).to eq user_registration_path
    expect(page).to have_content('Email is invalid')
  end

  scenario "with duplicate email" do
    sign_up_with('new_email@example.com', 'new_username', 'password')
    click_email_confirmation_link('new_email@example.com')

    sign_up_with('new_email@example.com', 'other_username', 'password')
    expect(current_path).to eq user_registration_path
    expect(page).to have_content('Email has already been taken')
  end

  scenario "with blank username" do
    sign_up_with('new_email@example.com', '', 'password')

    expect(current_path).to eq user_registration_path
    expect(page).to have_content("Username can't be blank")
  end

  scenario "with duplicate username" do
    sign_up_with('new_email@example.com', 'new_username', 'password')
    click_email_confirmation_link('new_email@example.com')

    sign_up_with('other_email@example.com', 'new_username', 'password')
    expect(current_path).to eq user_registration_path
    expect(page).to have_content('Username has already been taken')
  end

  scenario "with blank password" do
    sign_up_with('new_email@example.com', 'new_username', '')

    expect(current_path).to eq user_registration_path
    expect(page).to have_content("Password can't be blank")
  end

  after do
    clear_auth
  end

  private

  def click_email_confirmation_link(email)
    open_email(email, with_subject: "Confirmation instructions")
    visit_in_email("Confirm my account")
  end

  def sign_up_with(email, username, password)
    visit new_user_registration_path
    fill_in 'Username', with: username
    fill_in 'Email', with: email
    fill_in 'Password', with: password
    fill_in 'Password confirmation', with: password

    within 'form' do
      click_button 'Sign up'
    end
  end
end