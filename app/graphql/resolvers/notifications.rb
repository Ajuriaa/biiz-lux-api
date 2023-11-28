class Resolvers::Notifications < GraphQL::Schema::Resolver
  type [Types::NotificationType], null: true
  description 'Returns all the notifications available.'

  def resolve
    user = context[:current_user]
    ability = Ability.for(user)

    if %w[driver passenger].include?(user.role) && ability.can?(:read, Notification)
      Notification.current
    else
      raise GraphQL::ExecutionError, 'No tienes permisos para ver esta información.'
    end
  end
end
