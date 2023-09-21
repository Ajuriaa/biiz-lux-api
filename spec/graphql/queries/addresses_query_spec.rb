require 'rails_helper'

RSpec.describe BiizApiSchema do
  before do
    # reset vars and context
    prepare_query_variables({})
    prepare_context({})
  end

  describe 'addresses' do
    before do
      prepare_query('{
        addresses {
          name
        }
      }')
    end

    context 'when there is no current user' do
      it 'returns a runtime error' do
        expect { graphql! }.to raise_error(RuntimeError)
      end
    end

    context 'when there is not a passenger' do
      let!(:driver) { create(:driver) }
      let!(:user) { create(:user, userable: driver, role: 'driver') }

      before do
        prepare_context({ current_user: user })
      end

      it 'returns an error' do
        expect(graphql!['errors'][0]['message']).to eq('No tienes permisos para ver esta información.')
      end
    end

    context 'when there is a passenger' do
      let!(:passenger) { create(:passenger) }
      let!(:user) { create(:user, userable: passenger) }

      before do
        prepare_context({ current_user: user })
      end

      it 'returns the passenger addresses' do
        create(:address, passenger:, name: 'test')
        expect(graphql!['data']['addresses'][0]['name']).to eq('test')
      end
    end
  end
end
