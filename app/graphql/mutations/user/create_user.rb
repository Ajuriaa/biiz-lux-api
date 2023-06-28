class Mutations::User::CreateUser < GraphQL::Schema::Mutation
  null true
  description 'Create a new user.'
  argument :role, String, required: true
  argument :user_attributes, Inputs::UserInputType, required: true
  payload_type Types::UserType

  def resolve(role:, user_attributes:)
    user = user_attributes.to_kwargs

    if email_validation(user[:email])
      raise GraphQL::ExecutionError, 'Tu email ya fue registrado por otro usuario.'
    end

    new_user = CreateNewUser.run(role:, user_attributes: user)

    if new_user.valid?
      new_user.result
    else
      raise GraphQL::ExecutionError, new_user.errors[:user].first
    end
  end

  private

  def email_validation(email)
    User.exists?(email:)
  end
end
