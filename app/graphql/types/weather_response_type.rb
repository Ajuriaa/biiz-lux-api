module Types
  class WeatherResponseType < Types::BaseObject
    field :weather, [Types::WeatherType], null: true
    field :main, Types::MainWeatherInfoType, null: true
  end
end
