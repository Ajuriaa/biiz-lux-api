module Types
  class UserableType < Types::BaseObject
    field :id, ID, null: false
    field :score, Integer, null: true
    field :license, String, null: true
    field :license_expiration_date, String, null: true
    field :payment_method, String, null: true
    field :bilingual, Boolean, null: true
    field :experience, Integer, null: true
    field :full_name, String, null: false
    field :addresses, [Types::AddressType], null: true
  end
end
