require 'rails_helper'

RSpec.describe BizApiSchema do
  before do
    # reset vars and context
    prepare_query_variables({})
    prepare_context({})
  end

  describe 'current user' do
    before do
      prepare_query('{
        currentUser{
          email
          userable {
            score
          }
        }
      }')
    end

    context 'when there is no current user' do
      it 'returns a runtime error' do
        expect { graphql! }.to raise_error(RuntimeError)
      end
    end

    context 'when there is a current user' do
      let!(:driver) { create(:driver) }
      let!(:user) { create(:user, userable: driver) }

      before do
        prepare_context({ current_user: user })
      end

      it 'shows the user email' do
        expect(graphql!['data']['currentUser']['email']).to eq(user.email)
      end

      it 'returns the userable information' do
        expect(graphql!['data']['currentUser']['userable']['score']).to eq(user.userable.score)
      end
    end
  end
end
