class Mutations::User::UpdateUsername < GraphQL::Schema::Mutation
  null true
  description 'Update a username.'
  argument :user_id, Integer, required: true
  argument :username, String, required: true
  payload_type Types::UserType

  def resolve(user_id:, username:)
    current_user = context[:current_user]
    ability = Ability.for(current_user)

    if ability.can?(:update, User)
      raise GraphQL::ExecutionError, 'Usuario no existe.' unless User.exists?(id: user_id)
      raise GraphQL::ExecutionError, 'Nombre de usuario ya existe.' if User.find_by(username:)

      user = User.find_by(id: user_id)
      user.update(username:)
      user.save!
      user
    end
  end
end
