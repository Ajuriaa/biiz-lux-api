FactoryBot.define do
  factory :trip do
    driver
    passenger
    vehicle

    start_location { 0 }
    end_location { 0 }
    start_time { Time.zone.now }
    end_time { Time.zone.now }
    distance { 0 }
    fare { 0 }
  end
end
