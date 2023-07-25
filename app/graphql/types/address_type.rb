module Types
  class AddressType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: true
    field :longitude, String, null: true
    field :latitude, String, null: true
    field :primary, Boolean, null: true
    field :address, String, null: true
    field :passenger, Types::UserableType, null: false
  end
end
