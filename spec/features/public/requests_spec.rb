require 'rails_helper'
require 'capybara/rspec'

feature 'Request', js: true do

  scenario 'create' do
    @user = FactoryGirl.create(:user)
    @category = FactoryGirl.create(:request_category)

    login_as @user

    visit root_path

    click_link "New request"
    expect(page).to have_content('New request')

    within("#request_form") do
      find('input#request_title').set Faker::Hacker.say_something_smart
      find("select#request_category option[value='number:#{@category.id}']").click
      find(".content div[contenteditable=\"true\"]").set(Faker::Hacker.say_something_smart)
      find('input[type="submit"]').click
    end
    expect(page).to have_content('Request successfully created')
  end

  scenario 'send message' do
    @user = FactoryGirl.create(:user)
    @category = FactoryGirl.create(:request_category)
    @request = FactoryGirl.create(:request, {status: "opened"})

    login_as @user

    visit public_request_path(@request)

    @message_body = Faker::Hacker.say_something_smart

    find("#message_body div[contenteditable=\"true\"]").set(@message_body)
    find('#send').click
    
    expect(page).to have_content(@message_body)
  end

  scenario 'by status' do
    @user = FactoryGirl.create(:user)
    5.times {FactoryGirl.create(:request_category)}
    @request_opened = FactoryGirl.create(:request, status: 'opened')
    @request_closed = FactoryGirl.create(:request, status: 'closed')

    login_as @user

    visit public_requests_path({status: 'opened'})
    expect(page).to have_content(@request_opened.title)

    click_link "Closed"
    expect(page).to have_content(@request_closed.title)

    click_link "All"
    expect(page).to have_content(@request_opened.title)
    expect(page).to have_content(@request_closed.title)
  end

  scenario 'search' do
    @user = FactoryGirl.create(:user)
    @category = FactoryGirl.create(:request_category)
    @request = FactoryGirl.create(:request, {status: "opened"})

    login_as @user
    visit root_path
    
    find('input#search_field').set "#{@request.title.split(' ').first}\n"

    expect(page).to have_content(@request.title)

  end
end
