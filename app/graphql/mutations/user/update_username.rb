class Mutations::User::UpdateUsername < GraphQL::Schema::Mutation
  null true
  description 'Update a username.'
  argument :username, String, required: true
  payload_type Boolean

  def resolve(username:)
    current_user = context[:current_user]
    ability = Ability.for(current_user)

    if ability.can?(:update, User)
      raise GraphQL::ExecutionError, 'Nombre de usuario ya existe.' unless User.find_by(username:).nil?

      current_user.update!(username:)
      true
    end
  end
end
