class Mutations::Passenger::CreateAddress < GraphQL::Schema::Mutation
  null true
  description 'Create a new address.'
  argument :address_attributes, Inputs::AddressInputType, required: true
  payload_type Boolean

  def resolve(address_attributes:)
    address = address_attributes.to_kwargs
    current_user = context[:current_user]
    ability = Ability.for(current_user)

    if ability.can?(:create, Address) && current_user.role == 'passenger'
      address[:passenger] = current_user.userable
      Address.create(address)

      true
    else
      raise GraphQL::ExecutionError, 'No tienes permisos para crear una dirección.'
    end
  end
end
