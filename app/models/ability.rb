class Ability
  include CanCan::Ability

  def self.for(user)
    case user&.role
    when 'passenger'
      PassengerAbility.new(user)
    when 'driver'
      DriverAbility.new(user)
    when 'admin'
      AdminAbility.new(user)
    else
      raise 'You are not logged in!'
    end
  end

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    @user = user

    alias_action :create, :read, :update, :destroy, to: :crud
  end
end
