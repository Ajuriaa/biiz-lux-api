module Types
  class QueryType < Types::BaseObject
    # Profile
    field :current_user, resolver: Resolvers::CurrentUser

    # Driver
    field :driver_vehicles, resolver: Resolvers::DriverVehicles

    # Trip
    field :all_trips, resolver: Resolvers::AllTrips
  end
end
