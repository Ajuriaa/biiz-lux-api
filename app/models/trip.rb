class Trip < ApplicationRecord
  belongs_to :passenger
  belongs_to :driver
  belongs_to :vehicle
  belongs_to :event, optional: true

  STATES = %w[active completed canceled].freeze
  validates :status, inclusion: { in: STATES }
end
