FactoryBot.define do
  factory :driver do
    score { 0 }
    license { 'license-test' }
    license_expiration_date { Time.zone.now }
  end
end
