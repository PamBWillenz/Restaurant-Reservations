require 'rails_helper'

RSpec.describe Reservation, type: :model do
  let(:table) { create(:table, capacity: 4) } # This will save the table to the database
  let(:reservation) { build(:reservation, table: table) } # This will not save the reservation to the database

  it 'is valid with valid attributes' do
    expect(reservation).to be_valid
  end

  it 'can be persisted' do
    expect { reservation.save }.to change { Reservation.count }.by(1)
  end

  it "is not valid without a name" do
    reservation = build(:reservation, name: nil)
    expect(reservation).not_to be_valid
  end
  
  it "requires start time to be on the hour" do
    reservation.start_time = Time.current.change(min: 30)
    reservation.valid?
    expect(reservation.errors[:start_time]).to include("must start on the hour")
  end
  
  it "prevents double booking" do
    create(:reservation, table: table, start_time: reservation.start_time)
    reservation.valid?
    expect(reservation.errors[:table]).to include("is not available at that time")
  end
  
  it "prevents party size larger than table capacity" do
    reservation.party_size = 5
    reservation.valid?
    expect(reservation.errors[:party_size]).to include("exceeds the table's capacity")
  end
end