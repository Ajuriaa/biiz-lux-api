class Resolvers::Fare < GraphQL::Schema::Resolver
  type Float, null: true
  argument :driver_id, Integer, required: true
  argument :phone_battery, Integer, required: true
  argument :driver_availability, Integer, required: true
  argument :distance, Integer, required: true
  argument :estimated_arrival_time, Integer, required: true
  description 'Returns the fare for the specified arguments.'

  def resolve(driver_id:, phone_battery:, driver_availability:, distance:, estimated_arrival_time:)
    user = context[:current_user]
    ability = Ability.for(user)

    if user.role == 'passenger' && ability.can?(:read, Vehicle)
      driver_user = User.find_by(id: driver_id, role: 'driver')
      car_weight = driver_user.userable.main_vehicle.car_weight

      fare = FareAlgorithm.run(
        car_weight:,
        trip_time: 6.hours.ago,
        phone_battery:,
        driver_availability:,
        distance:,
        estimated_arrival_time:
      )

      if fare.valid?
        fare.result
      else
        raise GraphQL::ExecutionError, 'Ha ocurrido un error al calcular la tarifa.'
      end
    else
      raise GraphQL::ExecutionError, 'No tienes permisos para ver esta información.'
    end
  end
end
