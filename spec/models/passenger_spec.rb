require 'rails_helper'

RSpec.describe Passenger do
  let!(:passenger_user) { create(:user) }
  let!(:passenger) { create(:passenger, user_id: passenger_user.id) }

  it 'has a valid factory' do
    expect(passenger).to be_valid
  end
end
