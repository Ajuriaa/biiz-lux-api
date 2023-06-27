require 'rails_helper'

RSpec.describe Driver do
  it 'has a valid factory' do
    expect(create(:driver)).to be_valid
  end
end
