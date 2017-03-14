FactoryGirl.define do
  factory :request do
    title Faker::Lorem.sentence
    category_id 1
  end
end
