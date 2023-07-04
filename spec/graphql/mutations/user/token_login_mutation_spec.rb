require 'rails_helper'

RSpec.describe BiizApiSchema do
  before do
    # reset vars and context
    prepare_query_variables({})
    prepare_context({})

    # set query
    prepare_query("
      mutation tokenLogin{
        tokenLogin {
          username
        }
      }
    ")
  end

  let(:password) { SecureRandom.uuid }

  describe 'login' do
    context 'when no user exists' do
      it 'is nil' do
        expect(graphql!['data']['tokenLogin']).to be_nil
      end
    end

    context 'when there is a matching user' do
      before do
        current_user = create(
          :user,
          username: 'jhondoe',
          password:,
          password_confirmation: password
        )
        prepare_context({ current_user: })
      end

      it 'returns user object' do
        user_username = graphql!['data']['tokenLogin']['username']
        expect(user_username).to eq('jhondoe')
      end
    end
  end
end
