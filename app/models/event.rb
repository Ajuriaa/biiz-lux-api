class Event < ApplicationRecord
  has_many :trips

  CATEGORIES = %w[concerts trendy sports private].freeze
  validates :category, inclusion: { in: CATEGORIES }
end