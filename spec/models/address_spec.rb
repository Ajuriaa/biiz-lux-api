require 'rails_helper'

RSpec.describe Address do
  it 'has a valid factory' do
    expect(create(:address)).to be_valid
  end
end
