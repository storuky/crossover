require 'rails_helper'
require 'capybara/rspec'

feature 'Sign ', js: true do

  scenario 'in as user' do
    @user = FactoryGirl.create(:user)

    visit root_path
    login @user

    expect(page).to have_content('Successfully signed in')
    expect(page).to have_content('New request')
  end

  scenario 'in as admin' do
    visit root_path
    @admin = FactoryGirl.create(:user)
    @admin.add_role :admin

    login @admin

    expect(page).to have_content('admin')
  end

  scenario 'in as support agent' do
    visit root_path
    @support_agent = FactoryGirl.create(:user)
    @support_agent.add_role :support_agent

    login @support_agent

    expect(page).to have_content('support agent')
  end

  scenario 'up' do
    visit root_path
    register
    expect(page).to have_content('Welcome! You have signed up successfully.')
    expect(page).to have_content('New request')
  end
end

def login user
  within("#sign_form") do
    find('input[type="email"]').set user.email
    find('input[type="Password"]').set '123123123'
  end
  click_button "Login"
end

def register
  within("#sign_form") do
    click_link "Sign up"
    fill_in 'Name', :with => Faker::Name.first_name
    fill_in 'Email', :with => Faker::Internet.email
    fill_in 'Password', :with => '123123123'
    fill_in 'Password confirmation', :with => '123123123'
  end
  click_button "Register"
end
