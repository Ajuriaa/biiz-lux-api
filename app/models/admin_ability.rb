class AdminAbility < Ability
  def initialize(user)
    super(user)

    can :crud, User
    can :crud, Passenger
    can :crud, Driver
    can :crud, Admin
    can :crud, Trip
    can :crud, Vehicle
    can :crud, Address
  end
end
