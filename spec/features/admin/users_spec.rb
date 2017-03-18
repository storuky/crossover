require 'rails_helper'
require 'capybara/rspec'

feature 'Admin User', js: true do

  scenario 'update profile' do
    @user = FactoryGirl.create(:user)
    @admin = FactoryGirl.create(:user)
    @admin.add_role :admin

    login_as @admin

    visit root_path

    find('.toggle-sidebar').click

    click_link "Users"
    click_link @user.name
    expect(page).to have_content('Edit user')

    name = Faker::Name.name
    email = Faker::Internet.unique.email
    within("#user_form") do
      find("select#user_role option[value='string:support_agent']").click
      find('input#user_name').set name
      find('input#user_email').set email
      find('input#user_password').set "123456"
      find('input#user_password_confirmation').set "123456"

      find('input[type="submit"]').click
    end

    expect(page).to have_content('Successfully updated')
    @user.reload

    expect(@user.name).to eq(name)
    expect(@user.email).to eq(email)
    expect(@user.valid_password?("123456")).to eq(true)
    expect(@user.has_role?(:support_agent)).to eq(true)
  end

  scenario 'upload avatar' do
    @user = FactoryGirl.create(:user)
    @admin = FactoryGirl.create(:user)
    @admin.add_role :admin

    login_as @admin
    visit edit_admin_user_path(@user)

    within("#user_form") do
      file = Rails.root.join('spec', 'support', 'files', "avatar#{rand(7)+1}.png")
      raise 'File is not exist' unless File.exist?(file)
      find("#upload_avatar", visible: false).set(file)
      sleep 1
      @user.reload
      expect(page.evaluate_script("$('#user_avatar').attr('src')")).to eq @user.avatar.thumb.url
    end
  end

  scenario 'block & unblock account' do
    @user = FactoryGirl.create(:user)
    @admin = FactoryGirl.create(:user)
    @admin.add_role :admin

    login_as @admin

    visit edit_admin_user_path(@user)

    accept_confirm do
      find('#block').click
    end
    expect(page).to have_content("User was successfully blocked")
    @user.reload
    expect(@user.blocked).to eq(true)

    accept_confirm do
      find('#unblock').click
    end
    expect(page).to have_content("User was successfully unblocked")
    @user.reload
    expect(@user.blocked).to eq(false)
  end

  scenario 'support agent can`t edit users profiles' do
    @user = FactoryGirl.create(:user)
    @support_agent = FactoryGirl.create(:user)
    @support_agent.add_role :support_agent

    login_as @support_agent

    visit edit_admin_user_path(@user)
    
    expect(page).to have_current_path(admin_users_path)
    click_link @user.name
    expect(page).to have_content("Only admin can edit users!")
  end

  scenario 'search' do
    @user = FactoryGirl.create(:user)
    @admin = FactoryGirl.create(:user)
    @admin.add_role :admin

    login_as @admin
    visit admin_users_path

    find('input#search_field').set "#{@user.name.split(' ').first}\n"

    expect(page).to have_content(@user.name)
  end
end
