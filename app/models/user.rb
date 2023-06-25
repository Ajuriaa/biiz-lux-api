class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  include Tokenizable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :userable, polymorphic: true, optional: true

  def short_name
    "#{first_name.split.first} #{last_name.split.first}"
  end

  def full_name
    [first_name, last_name].join(' ').strip
  end
end
