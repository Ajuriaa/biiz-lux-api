class Resolvers::CurrentUser < GraphQL::Schema::Resolver
  type Types::UserType, null: true
  description 'Returns the current user profile'

  def resolve
    current_user = context[:current_user]
    ability = Ability.for(current_user)

    current_user if ability.can?(:read, User)
  end
end
