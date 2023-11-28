class Notification < ApplicationRecord
  scope :current, -> { where('due_date >= ?', Time.zone.today) }
  default_scope -> { order(due_date: :asc) }
end
