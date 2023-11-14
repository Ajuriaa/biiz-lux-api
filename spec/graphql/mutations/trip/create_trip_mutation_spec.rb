require 'rails_helper'

RSpec.describe BiizApiSchema do
  let!(:admin_user) { create(:user, :admin_user) }
  let!(:driver) { create(:driver, id: 3) }
  let!(:vehicle) { create(:vehicle, driver:) }
  let!(:passenger) { create(:passenger, id: 2) }
  let!(:passenger_user) { create(:user, :passenger_user, userable: passenger) }

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
    context 'when the user is not a passenger or driver' do
      before do
        prepare_query_variables(
          {
            passengerId: passenger_user.id,
            vehicleId: vehicle.id,
            tripAttributes: {
              startLocation: {
                lat: 1,
                lng: 1
              },
              endLocation: {
                lat: 1,
                lng: 1
              },
              startTime: '17:00',
              startAddress: '',
              endAddress: '',
              distance: rand(100..1000),
              fare: 1,
              status: 'pending'
            }
          }
        )
        prepare_context({ current_user: admin_user })
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
                lat: 1,
                lng: 1
              },
              endLocation: {
                lat: 1,
                lng: 1
              },
              startTime: '17:00',
              startAddress: '',
              endAddress: '',
              distance: rand(100..1000),
              fare: 1,
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
            passengerId: passenger_user.id,
            vehicleId: -1,
            tripAttributes: {
              startLocation: {
                lat: 1,
                lng: 1
              },
              endLocation: {
                lat: 1,
                lng: 1
              },
              startTime: '17:00',
              startAddress: '',
              endAddress: '',
              distance: rand(100..1000),
              fare: 1,
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

    context 'when the fields exist' do
      before do
        prepare_query_variables(
          {
            passengerId: passenger_user.id,
            vehicleId: vehicle.id,
            tripAttributes: {
              startLocation: {
                lat: 1,
                lng: 1
              },
              endLocation: {
                lat: 1,
                lng: 1
              },
              startTime: '17:00',
              startAddress: '',
              endAddress: '',
              distance: rand(100..1000),
              fare: 1,
              status: 'pending'
            }
          }
        )
        prepare_context({ current_user: passenger_user })
      end

      it 'returns the trip' do
        expect(graphql!['data']['createTrip']).to be_truthy
      end

      it 'creates the trip record' do
        graphql!
        expect(Trip.count).to eq(1)
      end
    end
  end
end
