FactoryBot.define do
  factory :checkin do
    weight 100
    association :event
    association :person
  end
end