class Driver < ApplicationRecord
  has_one :user, as: :userable
  has_many :vehicles
  has_many :trips

  delegate :full_name, :username, to: :user
  delegate :short_name, to: :user

  def main_vehicle
    vehicles.find_by(default: true)
  end
end
