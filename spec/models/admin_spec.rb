require 'rails_helper'

RSpec.describe Admin do
  it 'has a valid factory' do
    expect(create(:user, :admin_user)).to be_valid
  end
end
