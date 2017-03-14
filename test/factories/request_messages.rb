FactoryGirl.define do
  factory :request_message, class: 'Ticket::Message' do
    content Faker::Lorem.paragraph
    ticket_id 1
  end
end
