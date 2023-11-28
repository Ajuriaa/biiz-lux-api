class PassengerAbility < Ability
  def initialize(user)
    super(user)

    can %i[read update], Passenger, id: user.userable_id
    can %i[read update], User, id: user.id
    can %i[create read update], Trip
    can %i[create read update], Address
    can :read, Vehicle
    can :read, Event
    can :read, Driver
    can :read, Notification
  end
end
