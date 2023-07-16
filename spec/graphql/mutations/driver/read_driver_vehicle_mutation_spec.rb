require 'rails_helper'

RSpec.describe BiizApiSchema do
  let!(:driver_user) { create(:user, :driver_user) }
  let!(:driver) { create(:driver, user_id: driver_user.id, id: 1) }
  let!(:driver_no_vehicle) { create(:driver, user_id: driver_user.id, id: 2) }
  let!(:passenger_user) { create(:user, :passenger_user) }

  before do
    # reset vars and context
    prepare_query_variables({})
    prepare_context({})

    # set query
    prepare_query("
      mutation readDriverVehicle(
        $driverId: Int!
      ){
        readDriverVehicle(
          driverId: $driverId
        ){
          plate
        }
      }
    ")
  end

  describe 'read all driver vehicles' do
    context 'when the user is not a driver' do
      before do
        prepare_query_variables(
          {
            driverId: driver.id
          }
        )
        prepare_context({ current_user: passenger_user })
      end

      it 'returns an error' do
        expect(graphql!['errors'][0]['message']).to eq('No tienes permisos para ver vehiculos.')
      end
    end

    context 'when the driver does not exists' do
      before do
        prepare_query_variables(
          {
            driverId: -1
          }
        )
        prepare_context({ current_user: driver_user })
      end

      it 'returns an error' do
        expect(graphql!['errors'][0]['message']).to eq('Conductor no existe.')
      end
    end

    context 'when the driver has no vehicles' do
      before do
        prepare_query_variables(
          {
            driverId: driver_no_vehicle.id
          }
        )
        prepare_context({ current_user: driver_user })
      end

      it 'returns an error' do
        expect(graphql!['errors'][0]['message']).to eq('Conductor no tiene vehiculos.')
      end
    end

    context 'when the driver has vehicles' do
      let(:vehicle) { create(:vehicle, driver:) }

      before do
        prepare_query_variables(
          {
            driverId: vehicle.driver_id
          }
        )
        prepare_context({ current_user: driver_user })
      end

      it 'returns the driver vehicles' do
        expect(graphql!['data']['readDriverVehicle']).to be_truthy
      end
    end
  end
end
