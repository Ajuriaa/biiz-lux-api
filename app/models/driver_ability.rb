class DriverAbility < Ability
  def initialize(user)
    super(user)

    can %i[read update], Driver, id: user.userable_id
    can %i[read update], User, id: user.id
    can %i[create read update], Trip, driver_id: nil
    can %i[create read update], Vehicle
    can :read, Passenger
    can :read, Address
  end
end
