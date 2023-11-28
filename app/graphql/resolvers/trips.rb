class Resolvers::Trips < GraphQL::Schema::Resolver
  type [Types::TripType], null: true
  description 'Returns all the trips for a user.'

  def resolve
    user = context[:current_user]
    ability = Ability.for(user)

    if %w[driver passenger].include?(user.role) && ability.can?(:read, Trip)
      user.userable.trips
    else
      raise GraphQL::ExecutionError, 'No tienes permisos para ver esta información.'
    end
  end
end
