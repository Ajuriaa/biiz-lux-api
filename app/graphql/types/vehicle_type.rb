module Types
  class VehicleType < Types::BaseObject
    field :id, ID, null: false
    field :driver, Types::UserableType, null: false
    field :vehicle_type, String, null: true
    field :model, String, null: true
    field :plate, String, null: false
    field :year, Integer, null: true
    field :color, String, null: true
    field :registration, String, null: false
    field :registration_expiration_date, String, null: false
    field :image_url, String, null: true
  end
end
