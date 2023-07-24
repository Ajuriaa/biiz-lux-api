class Passenger < ApplicationRecord
  has_one :user, as: :userable
  has_many :trips
  has_many :addresses, dependent: :destroy
end
