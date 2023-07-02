Devise.setup do |config|
  # JWT configuration for devise-jwt
  config.secret_key = Rails.application.credentials.config_secret_key
  config.jwt do |jwt|
    jwt.secret = Rails.application.credentials.jwt_secret
    jwt.expiration_time = 1.month.to_i
  end
end
