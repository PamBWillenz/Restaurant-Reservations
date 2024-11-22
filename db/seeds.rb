# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# seed data for 20 reservations
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
  { name: "Table 10", capacity: 4 },
  { name: "Table 11", capacity: 6 },
  { name: "Table 12", capacity: 8 },
  { name: "Table 13", capacity: 2 },
  { name: "Table 14", capacity: 4 },
  { name: "Table 15", capacity: 6 },
  { name: "Table 16", capacity: 8 },
  { name: "Table 17", capacity: 2 },
  { name: "Table 18", capacity: 4 },
  { name: "Table 19", capacity: 6 },
  { name: "Table 20", capacity: 8 }
]

tables.each do |table|
  Table.create!(table)
end