class Resolvers::AllEvents < GraphQL::Schema::Resolver
  type [Types::EventType], null: true
  description 'Returns the list of events available.'

  def resolve
    user = context[:current_user]
    ability = Ability.for(user)

    if %w[driver passenger].include?(user.role) && ability.can?(:read, Event)
      Event.all
    else
      raise GraphQL::ExecutionError, 'No tienes permisos para ver esta información.'
    end
  end
end