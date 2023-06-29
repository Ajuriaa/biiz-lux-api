require 'rails_helper'

RSpec.describe BizApiSchema do
  before do
    # reset vars and context
    prepare_query_variables({})
    prepare_context({})

    # set query
    prepare_query("
      mutation logout{
        logout
      }
    ")
  end

  let(:password) { SecureRandom.uuid }

  describe 'logout' do
    context 'when no user exists' do
      it 'is false' do
        expect(graphql!['data']['logout']).to be false
      end
    end

    context 'when there is a matching user' do
      let(:user) do
        create(
          :user,
          username: Faker::Internet.username,
          password:,
          password_confirmation: password
        )
      end

      before do
        prepare_context({ current_user: user })
      end

      it 'returns user object' do
        jti_before = user.jti
        graphql!
        user.reload
        expect(user.jti).not_to eq jti_before
      end
    end
  end
end
