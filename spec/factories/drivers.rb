FactoryBot.define do
  factory :driver do
    score { 0 }
    license { 'license-test' }
    license_expiration_date { Time.zone.now }
    experience { 2 }
    bilingual { false }
  end
end
