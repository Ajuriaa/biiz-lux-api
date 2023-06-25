module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :username, String, null: false
    field :first_name, String, null: false
    field :last_name, String, null: false
    field :email, String, null: false
    field :short_name, String, null: false
    field :full_name, String, null: false
    field :token, String, null: false
    field :role, String, null: false
    field :first_password, String, null: true
    field :userable, Types::UserableType, null: true
    field :identification_number, String, null: false
    field :phone_number, String, null: false
  end
end
