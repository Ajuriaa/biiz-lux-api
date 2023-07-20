require 'rails_helper'

RSpec.describe BiizApiSchema do
  let!(:driver_user) { create(:user, :driver_user) }

  before do
    # reset vars and context
    prepare_query_variables({ username: 'test' })
    prepare_context({})

    # set query
    prepare_query("
      mutation updateUsername($username: String!){
        updateUsername(username: $username)
      }
    ")
  end

  describe 'update username' do
    context 'when there is no current user' do
      it 'returns a runtime error' do
        expect { graphql! }.to raise_error(RuntimeError)
      end
    end

    context 'when the username is occupied' do
      before do
        prepare_query_variables({ username: driver_user.username })
        prepare_context({ current_user: driver_user })
      end

      it 'returns an error' do
        expect(graphql!['errors'][0]['message']).to eq('Nombre de usuario ya existe.')
      end
    end

    context 'when the fields are valid' do
      before do
        prepare_query_variables({ username: 'newusername' })
        prepare_context({ current_user: driver_user })
      end

      it 'updates username' do
        expect(graphql!['data']['updateUsername']).to be true
      end
    end
  end
end
