module Types
  class LocationType < Types::BaseObject
    field :latitude, String, null: false
    field :longitude, String, null: false
  end
end
