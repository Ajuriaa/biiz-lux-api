module Types
  class TripType < Types::BaseObject
    field :id, ID, null: false
    field :passenger, Types::UserableType, null: false
    field :driver, Types::UserableType, null: false
    field :vehicle, Types::VehicleType, null: false
    field :start_location, Types::LocationType, null: false
    field :end_location, Types::LocationType, null: false
    field :start_time, String, null: false
    field :end_time, String, null: true
    field :distance, Float, null: false
    field :fare, String, null: false
    field :status, String, null: false
  end
end
