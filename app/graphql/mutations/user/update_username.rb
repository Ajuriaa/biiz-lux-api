class Mutations::User::UpdateUsername < GraphQL::Schema::Mutation
  null true
  description 'Update a username.'
  argument :username, String, required: true
  payload_type Types::UserType

  def resolve(username:)
    current_user = context[:current_user]
    ability = Ability.for(current_user)

    if ability.can?(:update, User)
      raise GraphQL::ExecutionError, 'Nombre de usuario ya existe.' if User.find_by(username:)

      user = User.find_by(id: current_user.id)
      user.update(username:)
      user.save!
      user
    end
  end
end
