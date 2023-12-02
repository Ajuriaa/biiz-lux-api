class Resolvers::ActiveTrip < GraphQL::Schema::Resolver
  type Types::TripType, null: true
  description 'Returns the current active trip for a passenger.'

  def resolve
    user = context[:current_user]
    ability = Ability.for(user)

    if %w[driver passenger].include?(user.role) && ability.can?(:read, Trip)
      user.userable.trips.find_by(status: 'active')
    else
      raise GraphQL::ExecutionError, 'No tienes permisos para ver esta información.'
    end
  end
end
