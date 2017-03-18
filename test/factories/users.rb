FactoryGirl.define do
  factory :user do
    email {Faker::Internet.unique.email}
    name {Faker::Name.name}
    # avatar {Rack::Test::UploadedFile.new(Rails.root.join('spec', 'support', 'files', "avatar#{rand(7)+1}.png"))}
    password {123123123}
  end
end
