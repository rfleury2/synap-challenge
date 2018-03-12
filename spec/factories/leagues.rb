FactoryBot.define do
  factory :league do
    name { "#{Faker::Name.last_name} Family #{Faker::Food.dish} Competition" }
    date { Date.today }
    association :event
  end
end