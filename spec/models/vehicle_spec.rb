require 'rails_helper'

RSpec.describe Vehicle do
  let!(:driver) { create(:driver) }
  let!(:vehicle) { create(:vehicle, driver:) }

  it 'has a valid factory' do
    expect(vehicle).to be_valid
  end
end
