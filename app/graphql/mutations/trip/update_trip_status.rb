class Mutations::Trip::UpdateTripStatus < GraphQL::Schema::Mutation
  null true
  description 'Updates a trip status.'
  argument :trip_id, Integer, required: true
  argument :status, String, required: true
  payload_type Boolean

  def resolve(trip_id:, status:)
    trip = Trip.find_by(id: trip_id)
    current_user = context[:current_user]
    ability = Ability.for(current_user)

    raise GraphQL::ExecutionError, 'No existe el viaje.' unless trip

    if ability.can?(:update, Trip) && %w[passenger driver].include?(current_user.role)
      end_time = DateTime.now
      trip.update!(status:, end_time:)
    else
      raise GraphQL::ExecutionError, 'No tienes permisos para actualizar un viaje.'
    end
  end
end
