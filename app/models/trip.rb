class Trip < ApplicationRecord
  belongs_to :passenger
  belongs_to :driver
  belongs_to :vehicle
end
