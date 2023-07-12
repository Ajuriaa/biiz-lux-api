require 'rails_helper'

RSpec.describe BiizApiSchema do
  before do
    # reset vars and context
    prepare_query_variables(
      {
        passenger_id: 1,
        driver_id: 2,
        vehicle_id: 3,
        trip_attributes: {
          start_location: {
            latitude: Faker::Address.latitude,
            longitude: Faker::Address.longitude
          },
          end_location: {
            latitude: Faker::Address.latitude,
            longitude: Faker::Address.longitude
          },
          start_time: Faker::Time.between(from: Time.zone.now, to: 2.hours.from_now),
          end_time: '',
          distance: rand(100..1000), # assuming distance is in meters
          fare: rand(5..15), # assuming currency is in dollars
          status: 'pending'
        }
      }
    )
    prepare_context({})

    # set query
    prepare_query("
      mutation createTrip(
        passenger_id: ID!,
        driver_id: ID!,
        vehicle_id: ID!,
        $userAttributes: TripInput!
      ){
            passenger_id: $passenger_id,
            driver_id: $driver_id,
            vehicle_id: $vehicle_id,
            userAttributes: $trip_attributes
      }
    ")
  end

  describe 'create new trip' do
    context 'when the passenger does not exists' do
      let!(:driver) { create(:driver) }
      let!(:vehicle) { create(:vehicle, driver:) }

      before do
        prepare_query_variables(
          {
            passenger_id: 1,
            driver_id: driver.id,
            vehicle_id: vehicle.id,
            trip_attributes: {
              start_location: {
                latitude: Faker::Address.latitude,
                longitude: Faker::Address.longitude
              },
              end_location: {
                latitude: Faker::Address.latitude,
                longitude: Faker::Address.longitude
              },
              start_time: Faker::Time.between(from: Time.zone.now, to: 2.days.from_now),
              end_time: '',
              distance: rand(100..1000), # assuming distance is in meters
              fare: rand(5..15), # assuming currency is in dollars
              status: 'pending'
            }
          }
        )
      end

      it 'returns an error' do
        expect(graphql!['errors'][0]['message']).to eq('Pasajero no registrado.')
      end
    end
  end
end
