class Trip < ApplicationRecord
  belongs_to :customer
  belongs_to :driver
  belongs_to :vehicle
end
