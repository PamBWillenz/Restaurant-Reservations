require 'rails_helper'

RSpec.describe Table, type: :model do
  it "is valid with valid attributes" do
    table = build(:table)
    expect(table).to be_valid
  end
  
  it "is not valid without a capacity" do
    table = build(:table, capacity: nil)
    expect(table).not_to be_valid
  end
  
  it "is not valid with a capacity less than 2" do
    table = build(:table, capacity: 1)
    expect(table).not_to be_valid
  end
  
  it "is not valid with a capacity greater than 8" do
    table = build(:table, capacity: 9)
    expect(table).not_to be_valid
  end
  
  it "is not valid with a non-integer capacity" do
    table = build(:table, capacity: 4.5)
    expect(table).not_to be_valid
  end
  
  it 'is not valid with a non-unique name' do
    create(:table, name: "Table 1")
    table = build(:table, name: "Table 1")
    expect(table).not_to be_valid
  end
end
