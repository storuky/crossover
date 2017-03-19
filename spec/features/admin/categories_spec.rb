require 'rails_helper'
require 'capybara/rspec'

feature 'Admin Category', js: true do

  scenario 'create' do
    login_as_admin

    visit root_path

    find('.toggle-sidebar').click if first('.sidebar.collapse')

    click_link "Categories"
    click_link "New category"
    expect(page).to have_content('New category')

    name = Faker::Commerce.product_name
    within("#category_form") do
      find('input#request_category_name').set name

      find('input[type="submit"]').click
    end

    sleep 1
    @category = Request::Category.first

    expect(page).to have_content('Category successfully created')
    expect(page).to have_content(@category.name)
    expect(@category.name).to eq(name)
  end

  scenario 'update' do
    login_as_admin

    @category = FactoryGirl.create(:request_category)

    visit edit_admin_request_category_path(@category)

    name = Faker::Commerce.product_name
    within("#category_form") do
      find('input#request_category_name').set name

      find('input[type="submit"]').click
    end

    sleep 1
    @category.reload

    expect(page).to have_content('Category successfully updated')
    expect(@category.name).to eq(name)
  end

  scenario 'destroy', focus: true do
    login_as_admin

    @category = FactoryGirl.create(:request_category)

    visit edit_admin_request_category_path(@category)

    name = Faker::Commerce.product_name
    
    find("#destroy_category").click

    sleep 1

    expect(page).to have_content('Category successfully deleted')

    expect(Request::Category.find_by(id: @category.id)).to be_nil
  end

end

def login_as_admin
  @user = FactoryGirl.create(:user)
  @admin = FactoryGirl.create(:user)
  @admin.add_role :admin
  login_as @admin
end
