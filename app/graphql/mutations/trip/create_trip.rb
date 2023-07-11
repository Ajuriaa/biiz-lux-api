class Mutations::Trip::CreateTrip < GraphQL::Schema::Mutation
  null true
  description 'Create a new trip.'
  argument :passenger_id, ID, 'passenger id', required: true
  argument :driver_id, ID, 'driver id', required: true
  argument :vehicle_id, ID, 'vehicle id', required: true
  argument :trip_attributes, Inputs::TripInputType, required: true
  payload_type Types::TripType

  def resolve(trip_attributes:)
    trip = trip_attributes.to_kwargs
    new_trip = CreateNewTrip(
      :passenger_id,
      :driver_id,
      :vehicle_id,
      trip_attributes: trip
    )

    if new_trip.valid?
      new_trip.result
    else
      raise GraphQL::ExecutionError, new_trip.errors.full_messages.join(', ')
    end
  end
end
