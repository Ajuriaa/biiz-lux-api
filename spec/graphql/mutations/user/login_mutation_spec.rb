require 'rails_helper'

RSpec.describe BizApiSchema do
  before do
    # reset vars and context
    prepare_query_variables({})
    prepare_context({})

    # set query
    prepare_query("
      mutation login($attributes: LoginInput!){
        login(attributes: $attributes) {
          username
        }
      }
    ")
  end

  let(:password) { SecureRandom.uuid }

  describe 'login' do
    context 'when no user exists' do
      before do
        prepare_query_variables(
          attributes: {
            username: Faker::Internet.username,
            password:
          }
        )
      end

      it 'returns error' do
        expect(graphql!['errors'][0]['message']).to eq('Usuario inválido')
      end
    end

    context "when there's a matching user" do
      let(:user) { create(:user) }

      before do
        prepare_query_variables(
          attributes: {
            username: user.username,
            password: 'password'
          }
        )
      end

      it 'returns user object' do
        user_username = graphql!['data']['login']['username']
        expect(user_username).to eq(user.username)
      end
    end

    context 'when there is a matching user but the password is wrong' do
      let!(:user) { create(:user) }

      before do
        prepare_query_variables(
          attributes: {
            username: user.username,
            password: 'wrongpassword'
          }
        )
      end

      it 'returns error' do
        expect(graphql!['errors'][0]['message']).to eq('Contraseña incorrecta')
      end
    end
  end
end
