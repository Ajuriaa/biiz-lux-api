class Mutations::Driver::ReadVehicle < GraphQL::Schema::Mutation
  null true
  description 'Read driver vehicles.'
  argument :driver_id, Integer, required: true
  payload_type [Types::VehicleType]

  def resolve(driver_id:)
    current_user = context[:current_user]
    ability = Ability.for(current_user)

    if ability.can?(:read, Vehicle) && current_user.role == 'driver'

      raise GraphQL::ExecutionError, 'Conductor no existe.' unless Driver.find_by(id: driver_id)
      raise GraphQL::ExecutionError, 'Conductor no tiene vehiculos.' unless Vehicle.find_by(driver_id:)

      Vehicle.where(driver_id:)
    else
      raise GraphQL::ExecutionError, 'No tienes permisos para ver vehiculos.'
    end
  end
end
