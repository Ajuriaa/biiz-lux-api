module Types
  class WeatherType < Types::BaseObject
    field :icon_uri, String, null: true
    field :icon, String, null: true
    field :main, String, null: true
    field :description, String, null: true
  end
end
