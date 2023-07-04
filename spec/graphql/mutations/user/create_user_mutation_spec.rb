require 'rails_helper'

RSpec.describe BiizApiSchema do
  before do
    # reset vars and context
    prepare_query_variables(
      {
        role: 'driver',
        userAttributes: {
          email: Faker::Internet.email,
          firstName: Faker::Name.first_name,
          lastName: Faker::Name.last_name,
          gender: 'male',
          birthdate: '24/12/2000',
          phoneNumber: Faker::PhoneNumber.phone_number,
          identificationNumber: Faker::IDNumber.brazilian_citizen_number,
          password: Faker::Internet.password
        }
      }
    )
    prepare_context({})

    # set query
    prepare_query("
      mutation createUser(
        $role: String!,
        $userAttributes: UserInput!
      ){
        signUp(
          role: $role,
          userAttributes: $userAttributes
        ) {
          username
          imageUrl
          role
        }
      }
    ")
  end

  describe 'create new user' do
    context 'when the email is occupied' do
      let!(:user) { create(:user, :admin_user) }

      before do
        prepare_query_variables(
          {
            role: 'driver',
            userAttributes: {
              email: user.email,
              firstName: Faker::Name.first_name,
              lastName: Faker::Name.last_name,
              gender: 'male',
              birthdate: '24/12/2000',
              phoneNumber: Faker::PhoneNumber.phone_number,
              identificationNumber: Faker::IDNumber.brazilian_citizen_number,
              password: Faker::Internet.password
            }
          }
        )
      end

      it 'returns an error' do
        expect(graphql!['errors'][0]['message']).to eq('Tu email ya fue registrado por otro usuario.')
      end
    end

    context 'when the phone number is occupied' do
      let!(:user) { create(:user, :admin_user) }

      before do
        prepare_query_variables(
          {
            role: 'driver',
            userAttributes: {
              email: Faker::Internet.email,
              firstName: Faker::Name.first_name,
              lastName: Faker::Name.last_name,
              gender: 'male',
              birthdate: '24/12/2000',
              phoneNumber: user.phone_number,
              identificationNumber: Faker::IDNumber.brazilian_citizen_number,
              password: Faker::Internet.password
            }
          }
        )
      end

      it 'returns an error' do
        expect(graphql!['errors'][0]['message']).to eq('Tu número de teléfono ya fue registrado por otro usuario.')
      end
    end

    context 'when the id number is occupied' do
      let!(:user) { create(:user, :admin_user) }

      before do
        prepare_query_variables(
          {
            role: 'driver',
            userAttributes: {
              email: Faker::Internet.email,
              firstName: Faker::Name.first_name,
              lastName: Faker::Name.last_name,
              gender: 'male',
              birthdate: '24/12/2000',
              phoneNumber: Faker::PhoneNumber.phone_number,
              identificationNumber: user.identification_number,
              password: Faker::Internet.password
            }
          }
        )
      end

      it 'returns an error' do
        expect(graphql!['errors'][0]['message']).to eq('Tu número de identidad ya fue registrado por otro usuario.')
      end
    end

    context 'when the fields are unique' do
      it 'returns the user' do
        expect(graphql!['data']['signUp']).to be_truthy
      end

      it 'creates the user record' do
        graphql!
        expect(User.count).to eq(1)
      end

      it 'creates the userable' do
        graphql!
        expect(User.first.userable_type).to eq('Driver')
      end
    end
  end
end
