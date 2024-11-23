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
  
  it "returns tables that can accommodate a party size" do
    table1 = create(:table, capacity: 4)
    table2 = create(:table, capacity: 6)
    table3 = create(:table, capacity: 8)
    
    expect(Table.can_accommodate(5)).to eq([table2, table3])
    expect(Table.can_accommodate(3)).to eq([table1, table2, table3])
    # expect table to not accommodate party size
    expect(Table.can_accommodate(9)).to eq([])
  end
end
