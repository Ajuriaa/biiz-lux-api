class UpdateUsername < BiizAction::Base
  params do
    param :user_id
    param :username
  end

  def execute
    return errors.add(:user, 'Usuario no existe.') unless User.exists?(id: user_id)
    return errors.add(:user, 'Nombre de usuario ya existe.') if User.find_by(username:)

    user = User.find_by(id: user_id)
    user.update(username:)
    user.save!
    user
  end
end
