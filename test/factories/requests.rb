FactoryGirl.define do
  factory :request_category, class: Request::Category do
    name {Faker::Commerce.product_name}
  end

  factory :request do
    title {Faker::Lorem.sentence}
    user_id {User.order("RAND()").first.id}
    category_id {Request::Category.order("RAND()").first.id}
    status {['opened', 'closed'].sample}

    before(:create) do |r|
      (rand(5)+1).times {
        r.messages.new({content: Faker::Lorem.paragraph, user_id: r.user_id})
      }
    end
  end
end