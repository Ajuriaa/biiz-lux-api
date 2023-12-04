class Passenger < ApplicationRecord
  has_one :user, as: :userable
  has_many :trips
  has_many :addresses, dependent: :destroy

  delegate :full_name, :username, to: :user
  delegate :short_name, to: :user
end
