module Types
  class QueryType < Types::BaseObject
    # Profile
    field :current_user, resolver: Resolvers::CurrentUser

    # Driver
    field :driver_vehicles, resolver: Resolvers::DriverVehicles
    field :driver_active_car, resolver: Resolvers::DriverActiveCar

    # Passenger
    field :addresses, resolver: Resolvers::Addresses

    # Trip
    field :all_trips, resolver: Resolvers::AllTrips
    field :trip, resolver: Resolvers::Trip
    field :trips, resolver: Resolvers::Trips
    field :active_trip, resolver: Resolvers::ActiveTrip

    # Weather
    field :weather, resolver: Resolvers::Weather

    # Events
    field :all_events, resolver: Resolvers::AllEvents
    field :notifications, resolver: Resolvers::Notifications

    # Fare
    field :fare, resolver: Resolvers::Fare
  end
end
