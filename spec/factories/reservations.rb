FactoryBot.define do
  factory :reservation do
    name { "MyString" }
    phone { "MyString" }
    party_size { 2 } # Updated to a valid value
    start_time { Time.current.beginning_of_hour + 1.hour }
    association :table
  end
end
