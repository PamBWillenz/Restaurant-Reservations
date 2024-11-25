class Reservation < ApplicationRecord
  belongs_to :table

  # Validations to ensure presence and correctness of reservation attributes
  validates :name, presence: true
  validates :phone, presence: true, format: { with: /\A\d{3}-\d{3}-\d{4}\z/ } 
  validates :party_size, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 2, less_than_or_equal_to: 8 }
  validates :start_time, presence: true
  
  # Custom validations
  validate :start_time_must_be_on_the_hour
  validate :table_must_be_available
  validate :party_size_must_fit_table

  # Scope to find reservations that overlap with a given start time
  scope :overlapping, ->(start_time) { 
    where(start_time: start_time..(start_time + 59.minutes)) 
  }

  private

  # Custom validation to ensure the start time is on the hour
  def start_time_must_be_on_the_hour
    unless start_time.min == 0
      errors.add(:start_time, "must start on the hour")
    end
  end

  # Custom validation to ensure the table is available at the requested time
  def table_must_be_available
    if table && Reservation.overlapping(start_time).where(table: table).exists?
      errors.add(:table, "is not available at that time")
    end
  end

  # Custom validation to ensure the party size does not exceed the table's capacity
  def party_size_must_fit_table
    if table && party_size && table.capacity < party_size
      errors.add(:party_size, "exceeds the table's capacity")
    end
  end
end