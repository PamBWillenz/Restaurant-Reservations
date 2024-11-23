FactoryBot.define do
  factory :table do
    # capacity is between 2 and 8
    capacity { rand(2..8) }
    sequence(:name) { |n| "Table #{n}" }
    # ensures that the name of each table is unique
  end
end
