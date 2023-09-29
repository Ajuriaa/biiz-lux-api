class Mutations::Trip::CreateTrip < GraphQL::Schema::Mutation
  null true
  description 'Create a new trip.'
  argument :passenger_id, Integer, required: true
  argument :vehicle_id, Integer, required: true
  argument :trip_attributes, Inputs::TripInputType, required: true
  payload_type Types::TripType

  def resolve(trip_attributes:, passenger_id:, vehicle_id:)
    trip = trip_attributes.to_kwargs
    current_user = context[:current_user]
    ability = Ability.for(current_user)
    

    if ability.can?(:create, Trip) && %w[passenger driver].include?(current_user.role)
      new_trip = CreateNewTrip.run(
        passenger_id:,
        vehicle_id:,
        trip_attributes: trip
      )

      if new_trip.valid?
        new_trip.result
      else
        raise GraphQL::ExecutionError, new_trip.errors[:trip].first
      end
    else
      raise GraphQL::ExecutionError, 'No tienes permisos para crear un viaje.'
    end
  end
end
