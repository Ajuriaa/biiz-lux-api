require 'rails_helper'

RSpec.describe Address do
  let!(:passenger_user) { create(:user) }
  let!(:passenger) { create(:passenger, user_id: passenger_user.id) }

  it 'has a valid factory' do
    expect(create(:address, passenger:)).to be_valid
  end
end
