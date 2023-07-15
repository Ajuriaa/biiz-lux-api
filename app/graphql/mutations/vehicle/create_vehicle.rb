class Mutations::Vehicle::CreateVehicle < GraphQL::Schema::Mutation
  null true
  description 'Create a new vehicle.'
  argument :driver_id, Integer, required: true
  argument :vehicle_attributes, Inputs::VehicleInputType, required: true
  payload_type Types::VehicleType

  def resolve(vehicle_attributes:, driver_id:)
    vehicle = vehicle_attributes.to_kwargs
    current_user = context[:current_user]
    ability = Ability.for(current_user)

    if ability.can?(:create, Vehicle) && current_user.role == 'driver'
      new_vehicle = CreateNewVehicle.run(
        driver_id:,
        vehicle_attributes: vehicle
      )

      if new_vehicle.valid?
        new_vehicle.result
      else
        raise GraphQL::ExecutionError, new_vehicle.errors[:vehicle].first
      end
    else
      raise GraphQL::ExecutionError, 'No tienes permisos para crear un vehiculo.'
    end
  end
end
