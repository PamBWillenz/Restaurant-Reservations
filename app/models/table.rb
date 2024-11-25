class Table < ApplicationRecord
  has_many :reservations, dependent: :destroy

  # Validations to ensure presence and correctness of table attributes
  validates :capacity, presence: true, 
                      numericality: { only_integer: true, greater_than_or_equal_to: 2,
                      less_than_or_equal_to: 8 }
  validates :name, presence: true, uniqueness: true

  # Scope to find tables that can accommodate a given party size, ordered by capacity
  scope :can_accommodate, ->(party_size) { where("capacity >= ?", party_size).order(capacity: :asc) }
end
