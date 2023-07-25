class Driver < ApplicationRecord
  has_one :user, as: :userable
  has_many :vehicles
  has_many :trips

  delegate :full_name, :username, to: :user
end
