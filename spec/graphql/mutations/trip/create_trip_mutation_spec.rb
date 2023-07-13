require 'rails_helper'

RSpec.describe BiizApiSchema do
  let!(:driver_user) { create(:user, :driver_user) }
  let!(:driver) { create(:driver, user_id: driver_user.id, id: 1) }
  let!(:vehicle) { create(:vehicle, driver:) }
  let!(:passenger_user) { create(:user, :passenger_user) }
  let!(:passenger) { create(:passenger, user_id: passenger_user.id, id: 2) }

  before do
    # reset vars and context
    prepare_query_variables({})
    prepare_context({})

    # set query
    prepare_query("
      mutation createTrip(
        $passengerId: Int!,
        $vehicleId: Int!,
        $tripAttributes: TripInput!
      ){
        createTrip(
          passengerId: $passengerId,
          vehicleId: $vehicleId,
          tripAttributes: $tripAttributes
        ){
          status
          driver{
            id
          }
          passenger{
            id
          }
        }
      }
    ")
  end

  describe 'create new trip' do
    context 'when the user is not a passenger' do
      before do
        prepare_query_variables(
          {
            passengerId: passenger.id,
            vehicleId: vehicle.id,
            tripAttributes: {
              startLocation: {
                latitude: '1',
                longitude: '1'
              },
              endLocation: {
                latitude: '1',
                longitude: '1'
              },
              startTime: '17:00',
              distance: rand(100..1000),
              fare: '1',
              status: 'pending'
            }
          }
        )
        prepare_context({ current_user: driver_user })
      end

      it 'returns an error' do
        expect(graphql!['errors'][0]['message']).to eq('No tienes permisos para crear un viaje.')
      end
    end

    context 'when the passenger does not exists' do
      before do
        prepare_query_variables(
          {
            passengerId: -1,
            vehicleId: vehicle.id,
            tripAttributes: {
              startLocation: {
                latitude: '1',
                longitude: '1'
              },
              endLocation: {
                latitude: '1',
                longitude: '1'
              },
              startTime: '17:00',
              distance: rand(100..1000),
              fare: '1',
              status: 'pending'
            }
          }
        )
        prepare_context({ current_user: passenger_user })
      end

      it 'returns an error' do
        expect(graphql!['errors'][0]['message']).to eq('Pasajero no existe.')
      end
    end

    context 'when the vehicle does not exists' do
      before do
        prepare_query_variables(
          {
            passengerId: passenger.id,
            vehicleId: -1,
            tripAttributes: {
              startLocation: {
                latitude: '1',
                longitude: '1'
              },
              endLocation: {
                latitude: '1',
                longitude: '1'
              },
              startTime: '17:00',
              distance: rand(100..1000),
              fare: '1',
              status: 'pending'
            }
          }
        )
        prepare_context({ current_user: passenger_user })
      end

      it 'returns an error' do
        expect(graphql!['errors'][0]['message']).to eq('Vehículo no existe.')
      end
    end
  end
end
