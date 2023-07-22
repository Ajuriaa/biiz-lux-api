module Types
  class MainWeatherInfoType < Types::BaseObject
    field :temp, String, null: true
    field :feels_like, String, null: true
  end
end
