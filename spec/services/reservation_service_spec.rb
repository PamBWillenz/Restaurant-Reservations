require 'rails_helper'

RSpec.describe ReservationService do
  let!(:table) { create(:table, capacity: 4) }
  
  describe '#create' do
    it "creates a reservation when a table is available" do
      params = {
        name: "John Doe",
        phone: "555-0123",
        party_size: "2",
        start_time: "2024-01-01 14:00:00",
        table_id: table.id
      }
      
      reservation = ReservationService.new(params).create_reservation
      expect(reservation).to be_persisted
      expect(reservation.table).to eq(table)
    end
    
    it "fails to create a reservation when no tables are available" do
      create(:reservation, table: table, start_time: "2024-01-01 14:00:00")
      
      params = {
        name: "Jane Smith",
        phone: "555-0124",
        party_size: "2",
        start_time: "2024-01-01 14:00:00",
        table_id: table.id
      }
      
      reservation = ReservationService.new(params).create_reservation
      expect(reservation).not_to be_persisted
      expect(reservation.errors[:base]).to include("No tables available for this party size at the requested time")
    end
  end
end