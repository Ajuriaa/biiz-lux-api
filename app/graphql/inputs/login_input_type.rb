class Inputs::LoginInputType < Types::BaseInputObject
  description 'Attributes to login.'
  argument :username, String, 'user username or email', required: true
  argument :password, String, 'user password', required: true
end
