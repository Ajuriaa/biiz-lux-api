class Driver < ApplicationRecord
  belongs_to :user
  has_many :vehicles
  has_many :trips
end
