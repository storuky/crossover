FactoryGirl.define do
  factory :request_category, class: 'Request::Category' do
    name Faker::Commerce.product_name
  end
end
