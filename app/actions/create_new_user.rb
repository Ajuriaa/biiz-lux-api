class CreateNewUser < BiizAction::Base
  params do
    param :role
    param :user_attributes # {}
  end

  def execute
    phone_number = user_attributes[:phone_number].scan(/\d/).join
    identification_number = user_attributes[:identification_number].scan(/\d/).join

    existing_user = User.exists?(phone_number:)
    return errors.add(:user, 'Tu número de teléfono ya fue registrado por otro usuario.') if existing_user

    existing_user = User.exists?(identification_number:)
    return errors.add(:user, 'Tu número de identidad ya fue registrado por otro usuario.') if existing_user

    user_attributes[:birthdate] = user_attributes[:birthdate].to_date
    user_attributes[:username] = generate_username(user_attributes[:first_name], user_attributes[:last_name])
    user_attributes[:image_url] = default_image_url(user_attributes[:gender])
    user_attributes[:role] = role
    create_user(user_attributes)
  end

  private

  def default_image_url(gender)
    "https://biiz-app-bucket.s3.us-east-2.amazonaws.com/#{gender}.png"
  end

  def generate_username(first_name, last_name, count = 1)
    first = first_name.split.first.parameterize
    last = last_name.split.first.parameterize

    username = count > 1 ? "#{first}#{last}#{format('%03d', rand(1..999))}#{count}" : "#{first}#{last}"
    user_exist = User.find_by(username:)

    if user_exist
      generate_username(first_name, last_name, count + 1)
    else
      username
    end
  end

  def create_userable(user)
    userable = nil

    case user.role
    when 'admin'
      userable = Admin.new(user_id: user.id)
    when 'driver'
      userable = Driver.new(user_id: user.id)
    when 'passenger'
      userable = Passenger.new(user_id: user.id)
    end

    userable&.save!
    user.update(userable:)

    userable
  end

  def create_user(user_attributes)
    new_user = User.new(user_attributes)
    new_user.save!
    create_userable(new_user)

    new_user
  end
end
