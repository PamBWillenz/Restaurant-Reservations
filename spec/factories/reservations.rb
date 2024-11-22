FactoryBot.define do
  factory :reservation do
    name { "MyString" }
    phone { "MyString" }
    party_size { 1 }
    start_time { "2024-11-22 16:37:41" }
    table { nil }
  end
end
