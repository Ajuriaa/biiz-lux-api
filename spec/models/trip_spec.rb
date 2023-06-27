require 'rails_helper'

RSpec.describe Trip do
  let!(:passenger_user) { create(:user) }
  let!(:passenger) { create(:passenger, user_id: passenger_user.id) }
  let!(:driver) { create(:driver) }
  let!(:vehicle) { create(:vehicle, driver:) }
  let!(:trip) { create(:trip, driver:, vehicle:, passenger:) }

  it 'has a valid factory' do
    expect(trip).to be_valid
  end
end
