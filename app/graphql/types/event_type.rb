module Types
  class EventType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :location_coordinates, Types::LocationType, null: false
    field :address_name, String, null: false
    field :category, String, null: false
    field :description, String, null: false
    field :image_url, String, null: false
    field :trips, [Types::TripType], null: true
  end
end
