module Types
  class QueryType < Types::BaseObject
    # Profile
    field :current_user, resolver: Resolvers::CurrentUser

    # Driver
    field :driver_vehicles, resolver: Resolvers::DriverVehicles

    # Passenger
    field :addresses, resolver: Resolvers::Addresses

    # Trip
    field :all_trips, resolver: Resolvers::AllTrips
    field :trip, resolver: Resolvers::Trip
    field :trips, resolver: Resolvers::Trips

    # Weather
    field :weather, resolver: Resolvers::Weather

    # Events
    field :all_events, resolver: Resolvers::AllEvents
    field :notifications, resolver: Resolvers::Notifications
  end
end
