class Admin < ApplicationRecord
  has_one :user, as: :userable
end
