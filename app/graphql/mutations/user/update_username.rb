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
      update_user = UpdateUsername.run(user_id:, username:)

      if update_user.valid?
        update_user.result
      else
        raise GraphQL::ExecutionError, update_user.errors[:user].first
      end
    else
      raise GraphQL::ExecutionError, 'No tienes permisos actualizar usuario.'
    end
  end
end
