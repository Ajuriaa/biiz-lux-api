module Types
  class MutationType < Types::BaseObject
    # Authentication
    field :login, mutation: Mutations::User::Login
    field :token_login, mutation: Mutations::User::TokenLogin
    field :logout, mutation: Mutations::User::Logout
    field :sign_up, mutation: Mutations::User::CreateUser

    # Trips
    field :create_trip, mutation: Mutations::Trip::CreateTrip
    field :update_trip_status, mutation: Mutations::Trip::UpdateTripStatus

    # User
    field :update_username, mutation: Mutations::User::UpdateUsername

    # Vehicles
    field :create_vehicle, mutation: Mutations::Vehicle::CreateVehicle

    # Address
    field :create_address, mutation: Mutations::Passenger::CreateAddress
  end
end
