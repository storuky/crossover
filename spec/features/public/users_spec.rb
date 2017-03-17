require 'rails_helper'
require 'capybara/rspec'

feature 'User ', js: true do

  scenario 'update profile' do
    @user = FactoryGirl.create(:user)

    login_as @user

    visit root_path

    click_link @user.name
    expect(page).to have_content('Profile')

    within("#user_form") do
      find('input#user_name').set Faker::Name.name
      find('input#user_email').set Faker::Internet.unique.email
      find('input#current_password').set "123123123"
      find('input#password').set "123456"
      find('input#password_confimation').set "123456"

      find('button[type="submit"]').click
    end
    expect(page).to have_content('Profile was successfully updated')
  end

  scenario 'cancel account', focus: true do
    @user = FactoryGirl.create(:user)

    login_as @user

    visit edit_public_users_path

    accept_confirm do
      find('#cancel').click
    end
    expect(page).to have_content('Sign In')
  end
end
