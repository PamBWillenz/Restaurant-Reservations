class Table < ApplicationRecord
  has_many :reservations

  validates :capacity, presence: true, 
                      numericality: { only_integer: true, greater_than_or_equal_to: 2,
                      less_than_or_equal_to: 8 }

  scope :can_accommodate, ->(party_size) { where("capacity >= ?", party_size).order(capacity: :asc) }
end
