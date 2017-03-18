require 'rails_helper'
require 'capybara/rspec'

feature 'User', js: true do

  scenario 'update profile' do
    @user = FactoryGirl.create(:user)

    login_as @user

    visit root_path

    click_link @user.name
    expect(page).to have_content('Profile')

    name = Faker::Name.name
    email = Faker::Internet.unique.email

    within("#user_form") do
      find('input#user_name').set name
      find('input#user_email').set email
      find('input#user_current_password').set "123123123"
      find('input#user_password').set "123456"
      find('input#user_password_confirmation').set "123456"

      find('button[type="submit"]').click
    end
    expect(page).to have_content('Profile was successfully updated')

    @user.reload
    expect(@user.name).to eq(name)
    expect(@user.email).to eq(email)
    expect(@user.valid_password?("123456")).to eq(true)
  end

  scenario 'upload avatar' do
    @user = FactoryGirl.create(:user)

    login_as @user

    visit edit_public_users_path

    within("#user_form") do
      file = Rails.root.join('spec', 'support', 'files', "avatar#{rand(7)+1}.png")
      raise 'File is not exist' unless File.exist?(file)
      find("#upload_avatar", visible: false).set(file)
      sleep 1
      @user.reload
      expect(page.evaluate_script("$('#user_avatar').attr('src')")).to eq @user.avatar.thumb.url
    end
  end

  scenario 'cancel account' do
    @user = FactoryGirl.create(:user)

    login_as @user

    visit edit_public_users_path

    accept_confirm do
      find('#cancel').click
    end
    expect(page).to have_content('Sign In')
  end
end
