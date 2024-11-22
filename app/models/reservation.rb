class Reservation < ApplicationRecord
  belongs_to :table

  validates :name, presence: true
  validates :phone, presence: true
  validates :party_size, presence: true, numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 8 }
  validates :start_time, presence: true
  validate :start_time_must_be_on_the_hour
  validate :table_must_be_available
  validate :party_size_must_fit_table

  scope :overlapping, ->(start_time) { 
    where(start_time: start_time..(start_time + 59.minutes)) 
  }

  private

  def start_time_must_be_on_the_hour
    unless start_time.min == 0
      errors.add(:start_time, "must be on the hour")
    end
  end

  def table_must_be_available
    if table && start_time && table.reservations.overlapping(start_time).where.not(id: id).exists?
      errors.add(:table, "is not available at that time")
    end
  end

  def party_size_must_fit_table
    if table && party_size && table.capacity < party_size
      errors.add(:party_size, "exceeds table capacity")
    end
  end
end