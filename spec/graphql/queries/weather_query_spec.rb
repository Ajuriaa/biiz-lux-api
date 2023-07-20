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
        weather{
          main {
            temp
          }
        }
      }')
    end

    context 'when there is no current user' do
      it 'returns a runtime error' do
        expect { graphql! }.to raise_error(RuntimeError)
      end
    end

    context 'when the user is authorized' do
      let!(:passenger_user) { create(:user, :passenger_user) }

      before do
        prepare_context({ current_user: passenger_user })
      end

      it 'returns the weather information' do
        expect(graphql!['data']['weather']['main']['temp']).to be_truthy
      end
    end
  end
end
