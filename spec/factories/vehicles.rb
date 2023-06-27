FactoryBot.define do
  factory :vehicle do
    driver

    vehicle_type { 0 }
    model { 'license-test' }
    plate { 'plate-test' }
    year { Time.zone.today.year }
    color { 'black' }
    registration { 'registration-test' }
    registration_expiration_date { Time.zone.now }
  end
end
