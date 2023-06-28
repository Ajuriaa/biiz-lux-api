class Mutations::User::Login < GraphQL::Schema::Mutation
  null true
  description "User's login."
  argument :attributes, Inputs::LoginInputType, required: true
  payload_type Types::UserType

  def resolve(attributes:)
    attributes = attributes.to_kwargs
    user = User.find_for_authentication(email: attributes[:username]) ||
           User.find_for_authentication(username: attributes[:username])
    return raise GraphQL::ExecutionError, 'Usuario inválido' unless user

    valid_for_auth = user.valid_for_authentication? ? user.valid_password?(attributes[:password]) : false
    if valid_for_auth
      user
    else
      raise GraphQL::ExecutionError, 'Invalid credentials'
    end
  end
end
