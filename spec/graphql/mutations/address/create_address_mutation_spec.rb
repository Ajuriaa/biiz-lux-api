require 'rails_helper'

RSpec.describe BiizApiSchema do
  before do
    # reset vars and context
    prepare_query_variables({
                              addressInput: {
                                name: 'test',
                                latitude: '1',
                                longitude: '1',
                                primary: true,
                                address: 'address information'
                              }
                            })
    prepare_context({})

    # set query
    prepare_query("
      mutation createAddress($addressInput: AddressInput!) {
        createAddress(addressAttributes: $addressInput)
      }
    ")
  end

  describe 'create new address' do
    context 'when there is no current user' do
      it 'is nil' do
        expect { graphql! }.to raise_error(RuntimeError)
      end
    end

    context 'when the user is not a passenger' do
      let!(:driver_user) { create(:user, :driver_user) }

      before do
        prepare_context({ current_user: driver_user })
      end

      it 'returns an error' do
        expect(graphql!['errors'][0]['message']).to eq('No tienes permisos para crear una dirección.')
      end
    end

    context 'when the user is a passenger' do
      let!(:passenger) { create(:passenger) }
      let!(:passenger_user) { create(:user, :passenger_user, userable: passenger) }

      before do
        prepare_context({ current_user: passenger_user })
      end

      it 'returns the user' do
        expect(graphql!['data']['createAddress']).to be true
      end

      it 'creates the database record' do
        graphql!
        expect(Address.count).to eq(1)
      end

      it 'relates the userable with the address' do
        graphql!
        expect(passenger.addresses.first.name).to eq('test')
      end
    end
  end
end
