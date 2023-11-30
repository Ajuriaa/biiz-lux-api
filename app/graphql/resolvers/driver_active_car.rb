class Resolvers::DriverActiveCar < GraphQL::Schema::Resolver
  type Types::VehicleType, null: true
  argument :driver_id, Integer, required: true
  description 'Returns the current active car for the driver.'

  def resolve(driver_id:)
    user = context[:current_user]
    ability = Ability.for(user)

    if user.role == 'passenger' && ability.can?(:read, Vehicle)
      driver_user = User.find_by(id: driver_id, role: 'driver')
      raise GraphQL::ExecutionError, 'El conductor no existe.' unless driver_user

      driver_user.userable.main_vehicle
    else
      raise GraphQL::ExecutionError, 'No tienes permisos para ver esta información.'
    end
  end
end
