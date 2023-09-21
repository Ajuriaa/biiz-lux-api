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

    # Weather
    field :weather, resolver: Resolvers::Weather
  end
end
