require 'rails_helper'

RSpec.describe BiizApiSchema do
  before do
    # reset vars and context
    prepare_query_variables({})
    prepare_context({})
  end

  describe 'driver vehicles' do
    before do
      prepare_query('{
        driverVehicles {
          id
        }
      }')
    end

    context 'when there is no current user' do
      it 'returns a runtime error' do
        expect { graphql! }.to raise_error(RuntimeError)
      end
    end

    context 'when the user is not a driver' do
      let!(:passenger_user) { create(:user, :passenger_user) }

      before do
        prepare_context({ current_user: passenger_user })
      end

      it 'returns an error' do
        expect(graphql!['errors'][0]['message']).to eq('No tienes permisos para ver esta información.')
      end
    end

    context 'when the user is a driver' do
      let!(:driver) { create(:driver) }
      let!(:driver_user) { create(:user, :driver_user, userable: driver) }

      before do
        create(:vehicle, driver_id: driver.id)
        create(:vehicle, driver_id: driver.id)
        prepare_context({ current_user: driver_user })
      end

      it 'returns the vehicles information' do
        expect(graphql!['data']['driverVehicles'].count).to eq(2)
      end
    end
  end
end
