module Types
  class QueryType < Types::BaseObject
    # Profile
    field :current_user, resolver: Resolvers::CurrentUser

    # Driver
    field :driver_vehicles, resolver: Resolvers::DriverVehicles
  end
end
