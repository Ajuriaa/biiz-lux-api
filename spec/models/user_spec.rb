require 'rails_helper'

RSpec.describe User do
  it 'has a valid factory' do
    expect(create(:user, :admin_user)).to be_valid
  end

  # Validations
  it { is_expected.to validate_presence_of(:username) }
  it { is_expected.to validate_length_of(:username).is_at_most(50) }
  it { is_expected.to validate_presence_of(:first_name) }
  it { is_expected.to validate_presence_of(:last_name) }

  # Callbacks
  describe '#set_default_role' do
    let(:user) { build(:user) }

    it 'sets role to admin' do
      expect(user.role).to eq 'passenger'
    end
  end

  # Methods
  describe '#full_name' do
    it 'returns first and lastname' do
      expect(create(:user, first_name: 'A', last_name: 'B').full_name).to eq 'A B'
    end
  end
end
