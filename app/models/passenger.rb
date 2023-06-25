class Passenger < ApplicationRecord
  has_one :user, as: :userable
  has_many :trips
end
