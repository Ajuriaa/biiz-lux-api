require 'rails_helper'

RSpec.describe BiizApiSchema do
  let!(:driver_user) { create(:user, :driver_user) }
  let!(:driver) { create(:driver, user_id: driver_user.id, id: 1) }
  let!(:passenger_user) { create(:user, :passenger_user) }
  let!(:passenger) { create(:passenger, user_id: passenger_user.id, id: 2) }

  before do
    # reset vars and context
    prepare_query_variables({})
    prepare_context({})

    # set query
    prepare_query("
      mutation createVehicle(
        $driverId: Int!,
        $vehicleAttributes: VehicleInput!
      ){
        createVehicle(
          driverId: $driverId,
          vehicleAttributes: $vehicleAttributes
        ){
          plate
        }
      }
    ")
  end

  describe 'create new trip' do
    context 'when the user is not a driver' do
      before do
        prepare_query_variables(
          {
            driverId: driver.id,
            vehicleAttributes: {
              vehicleType: 'Sport',
              model: 'Honda Civic',
              plate: 'IAMC4RR1',
              year: 2023,
              color: 'gray',
              registration: 'XYV5678',
              registrationExpirationDate: '05-05-2025'
            }
          }
        )
        prepare_context({ current_user: passenger_user })
      end

      it 'returns an error' do
        expect(graphql!['errors'][0]['message']).to eq('No tienes permisos para crear un vehiculo.')
      end
    end

    context 'when the driver does not exists' do
      before do
        prepare_query_variables(
          {
            driverId: passenger.id,
            vehicleAttributes: {
              vehicleType: 'Sport',
              model: 'Honda Civic',
              plate: 'IAMC4RR1',
              year: 2023,
              color: 'gray',
              registration: 'XYV5678',
              registrationExpirationDate: '05-05-2025'
            }
          }
        )
        prepare_context({ current_user: driver_user })
      end

      it 'returns an error' do
        expect(graphql!['errors'][0]['message']).to eq('Conductor no existe.')
      end
    end

    context 'when the date is not valid' do
      before do
        prepare_query_variables(
          {
            driverId: driver.id,
            vehicleAttributes: {
              vehicleType: 'Sport',
              model: 'Honda Civic',
              plate: 'IAMC4RR1',
              year: 2023,
              color: 'gray',
              registration: 'XYV5678',
              registrationExpirationDate: '05-05-2021'
            }
          }
        )
        prepare_context({ current_user: driver_user })
      end

      it 'returns an error' do
        expect(graphql!['errors'][0]['message']).to eq('Fecha de registro tiene que ser vigente.')
      end
    end

    context 'when the fields exist' do
      before do
        prepare_query_variables(
          {
            driverId: driver.id,
            vehicleAttributes: {
              vehicleType: 'Sport',
              model: 'Honda Civic',
              plate: 'IAMC4RR1',
              year: 2023,
              color: 'gray',
              registration: 'XYV5678',
              registrationExpirationDate: '05-05-2030'
            }
          }
        )
        prepare_context({ current_user: driver_user })
      end

      it 'returns the vehicle' do
        expect(graphql!['data']['createVehicle']['plate']).to eq('IAMC4RR1')
      end

      it 'creates the vehicle record' do
        graphql!
        expect(Vehicle.count).to eq(1)
      end
    end
  end
end
