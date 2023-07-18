class Resolvers::DriverVehicles < GraphQL::Schema::Resolver
  type [Types::VehicleType], null: true
  description 'Returns the list of vehicles for the current driver.'

  def resolve
    driver_user = context[:current_user]
    ability = Ability.for(driver_user)

    if driver_user.role == 'driver' && ability.can?(:read, Vehicle)
      driver_user.userable.vehicles
    else
      raise GraphQL::ExecutionError, 'No tienes permisos para ver esta información.'
    end
  end
end
