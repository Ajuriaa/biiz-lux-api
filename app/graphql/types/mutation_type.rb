module Types
  class MutationType < Types::BaseObject
    # Authentication
    field :login, mutation: Mutations::User::Login
    field :token_login, mutation: Mutations::User::TokenLogin
    field :logout, mutation: Mutations::User::Logout
    field :sign_up, mutation: Mutations::User::CreateUser

    # Trips
    field :create_trip, mutation: Mutations::Trip::CreateTrip

    # Driver
    field :read_driver_vehicle, mutation: Mutations::Driver::ReadDriverVehicle
  end
end
