require 'rails_helper'
require 'capybara/rspec'

feature 'Admin Request', js: true do

  scenario 'filter' do
    @support_agent = FactoryGirl.create(:user)
    @support_agent.add_role :support_agent

    @request_opened_readed = create_request(status: 'opened')
    @request_opened_readed.read! :support
    
    @request_opened = create_request(status: 'opened')

    @request_closed = create_request(status: 'closed')
    @request_closed.read! :support

    login_as @support_agent
    visit root_path
    
    find('.toggle-sidebar').click if first('.sidebar.collapse')

    click_link "Requests"

    expect(page).to have_content(@request_opened.title)
    expect(page).to have_content(@request_opened_readed.title)

    find(".switcher-item", :text => "Closed").click
    expect(page).to have_content(@request_closed.title)

    find(".switcher-item", :text => "All").click
    expect(page).to have_content(@request_opened.title)
    expect(page).to have_content(@request_closed.title)
    
    find(".switcher-item", :text => "Opened").click
    find("#filter_unreaded").click
    expect(page).to have_no_content(@request_opened_readed.title)
    expect(page).to have_content(@request_opened.title)

    # TODO: etc...
  end

  scenario 'read & send message' do
    @user = FactoryGirl.create(:user)
    @support_agent = FactoryGirl.create(:user)
    @support_agent.add_role :support_agent

    @request = create_request(status: 'opened', user_id: @user.id)

    login_as @support_agent
    visit admin_request_path(@request)

    expect(page).to have_content(@request.title)
    send_message
    expect(page).to have_content(@message_body)
    sleep 1
    @request.reload

    expect(@request.new_messages_count_for_support).to eq(0)
  end

  scenario 'open & close request' do
    @user = FactoryGirl.create(:user)
    @support_agent = FactoryGirl.create(:user)
    @support_agent.add_role :support_agent

    @request = create_request(status: 'opened', user_id: @support_agent.id)

    login_as @support_agent
    visit admin_request_path(@request)

    accept_confirm do
      find('#close_request').click
    end
    sleep 1
    @request.reload
    expect(page).to have_content("Open request")
    expect(@request.status).to eq("closed")

    accept_confirm do
      find('#open_request').click
    end
    sleep 1
    @request.reload
    expect(page).to have_content("Close request")
    expect(@request.status).to eq("opened")
  end

  scenario 'search' do
    @user = FactoryGirl.create(:user)
    @support_agent = FactoryGirl.create(:user)
    @support_agent.add_role :support_agent

    @request = create_request(status: "opened", user_id: @user.id)

    login_as @support_agent
    visit root_path
    
    find('input#search_field').set "#{@request.title.split(' ').first}\n"

    expect(page).to have_content(@request.title)
  end
end

def send_message body = nil
    @message_body = body || Faker::Hacker.say_something_smart
    find("#message_body div[contenteditable=\"true\"]").set(@message_body)
    find('#send').click
end

def create_request options = {}
    FactoryGirl.create(:request_category)
    request = FactoryGirl.create(:request, options)
    request.reload
end
