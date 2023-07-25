require 'rails_helper'

RSpec.describe BiizApiSchema do
  let!(:passenger) { create(:passenger) }
  let!(:passenger_user) { create(:user, userable: passenger) }
  let!(:driver) { create(:driver) }
  let!(:driver_user) { create(:user, :driver_user, userable: driver) }
  let!(:vehicle) { create(:vehicle, driver:) }

  before do
    # reset vars and context
    prepare_query_variables({ tripId: 0 })
    prepare_context({})
  end

  describe 'current user trip list' do
    before do
      prepare_query('
        query trip($tripId: Int!) {
          trip(tripId: $tripId) {
            passenger {
              fullName
            }
          }
        }
      ')
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
      let!(:trip) { create(:trip, driver:, vehicle:, passenger:) }

      before do
        prepare_query_variables({ tripId: trip.id })
        prepare_context({ current_user: driver_user })
      end

      it 'returns the trip information' do
        expect(graphql!['data']['trip']['passenger']['fullName']).to eq(passenger_user.full_name)
      end
    end
  end
end
