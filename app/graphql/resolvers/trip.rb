class Resolvers::Trip < GraphQL::Schema::Resolver
  type Types::TripType, null: true
  description 'Returns the information for one trip.'
  argument :trip_id, Integer, required: true

  def resolve(trip_id:)
    user = context[:current_user]
    ability = Ability.for(user)
    trip = Trip.find_by(id: trip_id)

    if %w[driver passenger].include?(user.role) && ability.can?(:read, Trip)
      raise GraphQL::ExecutionError, 'El viaje seleccionado no existe.' if trip.nil?

      trip
    else
      raise GraphQL::ExecutionError, 'No tienes permisos para ver esta información.'
    end
  end
end
