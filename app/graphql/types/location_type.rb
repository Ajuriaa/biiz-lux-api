module Types
  class LocationType < Types::BaseObject
    field :lat, String, null: false
    field :lng, String, null: false
  end
end
