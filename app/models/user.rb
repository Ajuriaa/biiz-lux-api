class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  include Tokenizable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :userable, polymorphic: true, optional: true
  has_many :addresses, dependent: :destroy
  GENDERS = %w[female male].freeze
  enum role: { admin: 0, passenger: 1, driver: 2 }, _suffix: true
  after_initialize :set_default_role, if: :new_record?

  validates :gender, inclusion: { in: GENDERS }
  validates :username, presence: true
  validates :username, length: { maximum: 50 }
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :gender, presence: true

  def short_name
    "#{first_name.split.first} #{last_name.split.first}"
  end

  def full_name
    [first_name, last_name].join(' ').strip
  end

  def jwt_subject
    id.to_s
  end

  private

  def set_default_role
    self.role ||= :passenger
  end
end
