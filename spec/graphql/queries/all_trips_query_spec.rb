require 'rails_helper'

RSpec.describe BiizApiSchema do
  before do
    # reset vars and context
    prepare_query_variables({})
    prepare_context({})
  end

  describe 'current user trip list' do
    before do
      prepare_query('{
        allTrips {
          id
        }
      }')
    end

    context 'when there is no current user' do
      it 'returns a runtime error' do
        expect { graphql! }.to raise_error(RuntimeError)
      end
    end

    context 'when the user is not a driver or passenger' do
      let!(:admin) { create(:user, :admin_user) }

      before do
        prepare_context({ current_user: admin })
      end

      it 'returns an error' do
        expect(graphql!['errors'][0]['message']).to eq('No tienes permisos para ver esta información.')
      end
    end

    context 'when the user is a driver or passenger' do
      let!(:passenger_user) { create(:user) }
      let!(:passenger) { create(:passenger, user_id: passenger_user.id) }
      let!(:driver) { create(:driver) }
      let!(:driver_user) { create(:user, :driver_user, userable: driver) }
      let!(:vehicle) { create(:vehicle, driver:) }

      before do
        create(:trip, driver:, vehicle:, passenger:)
        create(:trip, driver:, vehicle:, passenger:)
        prepare_context({ current_user: driver_user })
      end

      it 'returns the trip list' do
        expect(graphql!['data']['allTrips'].count).to eq(2)
      end
    end
  end
end
