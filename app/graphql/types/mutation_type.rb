module Types
  class MutationType < Types::BaseObject
    # Authentication
    field :login, mutation: Mutations::User::Login
    field :token_login, mutation: Mutations::User::TokenLogin
    field :logout, mutation: Mutations::User::Logout
  end
end
