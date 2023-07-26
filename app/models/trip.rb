class Trip < ApplicationRecord
  belongs_to :passenger
  belongs_to :driver
  belongs_to :vehicle

  STATES = %w[active completed canceled].freeze
  validates :status, inclusion: { in: STATES }
end
