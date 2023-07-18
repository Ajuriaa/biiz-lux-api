require 'rails_helper'

RSpec.describe BiizApiSchema do
  let!(:driver_user) { create(:user, :driver_user) }

  before do
    # reset vars and context
    prepare_query_variables({})
    prepare_context({})

    # set query
    prepare_query("
      mutation updateUsername(
        $username: String!
      ){
        updateUsername(
          username: $username
        ){
          id
          username
        }
      }
    ")
  end

  describe 'update username' do
    context 'when the username exist' do
      before do
        prepare_query_variables(
          {
            username: driver_user.username
          }
        )
        prepare_context({ current_user: driver_user })
      end

      it 'returns an error' do
        expect(graphql!['errors'][0]['message']).to eq('Nombre de usuario ya existe.')
      end
    end

    context 'when the fields are valid' do
      before do
        prepare_query_variables(
          {
            username: 'newuser01'
          }
        )
        prepare_context({ current_user: driver_user })
      end

      it 'returns the trip' do
        expect(graphql!['data']['updateUsername']).to be_truthy
      end

      it 'updates username' do
        expect(graphql!['data']['updateUsername']['username']).to eq('newuser01')
      end
    end
  end
end
