# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# seed data for 20 reservations
# Create tables
tables = [
  { name: "Table 1", capacity: 2 },
  { name: "Table 2", capacity: 4 },
  { name: "Table 3", capacity: 6 },
  { name: "Table 4", capacity: 8 },
  { name: "Table 5", capacity: 2 },
  { name: "Table 6", capacity: 4 },
  { name: "Table 7", capacity: 6 },
  { name: "Table 8", capacity: 8 },
  { name: "Table 9", capacity: 2 },
  { name: "Table 10", capacity: 4 }
]

tables.each do |table|
  Table.find_or_create_by!(name: table[:name]) do |t|
    t.capacity = table[:capacity]
  end
end

# Create reservations
reservations = [
  { name: "John Doe", phone: "123-456-7890", party_size: 2, start_time: Time.zone.now.beginning_of_hour + 1.hour, table: Table.find_by(name: "Table 1") },
  { name: "Jane Smith", phone: "098-765-4321", party_size: 4, start_time: Time.zone.now.beginning_of_hour + 2.hours, table: Table.find_by(name: "Table 2") },
  { name: "Alice Johnson", phone: "111-222-3333", party_size: 6, start_time: Time.zone.now.beginning_of_hour + 3.hours, table: Table.find_by(name: "Table 3") },
  { name: "Bob Brown", phone: "444-555-6666", party_size: 8, start_time: Time.zone.now.beginning_of_hour + 4.hours, table: Table.find_by(name: "Table 4") },
  { name: "Charlie Davis", phone: "777-888-9999", party_size: 2, start_time: Time.zone.now.beginning_of_hour + 5.hours, table: Table.find_by(name: "Table 5") },
  { name: "Diana Evans", phone: "000-111-2222", party_size: 4, start_time: Time.zone.now.beginning_of_hour + 6.hours, table: Table.find_by(name: "Table 6") },
  { name: "Eve Foster", phone: "333-444-5555", party_size: 6, start_time: Time.zone.now.beginning_of_hour + 7.hours, table: Table.find_by(name: "Table 7") },
  { name: "Frank Green", phone: "666-777-8888", party_size: 8, start_time: Time.zone.now.beginning_of_hour + 8.hours, table: Table.find_by(name: "Table 8") },
  { name: "Grace Harris", phone: "999-000-1111", party_size: 2, start_time: Time.zone.now.beginning_of_hour + 9.hours, table: Table.find_by(name: "Table 9") },
  { name: "Henry Irving", phone: "222-333-4444", party_size: 4, start_time: Time.zone.now.beginning_of_hour + 10.hours, table: Table.find_by(name: "Table 10") }
]

reservations.each do |reservation|
  Reservation.create!(reservation)
end