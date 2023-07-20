class Resolvers::Weather < GraphQL::Schema::Resolver
  type Types::WeatherResponseType, null: true
  description 'Returns the current weather.'

  def resolve
    user = context[:current_user]
    ability = Ability.for(user)

    if %w[passenger driver].include?(user&.role) && ability
      client = OpenWeather::Client.new(
        api_key: Rails.application.credentials.weather_api_key
      )
      client.current_weather(city: 'Tegucigalpa', units: 'metric', lang: 'es')
    else
      raise GraphQL::ExecutionError, 'No tienes permisos para ver esta información.'
    end
  end
end
