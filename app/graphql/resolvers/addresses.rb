class Resolvers::Addresses < GraphQL::Schema::Resolver
  type [Types::AddressType], null: true
  description 'Returns the addresses for the current user.'

  def resolve
    user = context[:current_user]
    ability = Ability.for(user)

    if user.role == 'passenger' && ability.can?(:read, Address)
      user.userable.addresses
    else
      raise GraphQL::ExecutionError, 'No tienes permisos para ver esta información.'
    end
  end
end
