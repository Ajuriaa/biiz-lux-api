FactoryBot.define do
  factory :address do
    user
    name { 'Home' }
    longitude { '12.345' }
    latitude { '67.890' }
    primary { true }
    address { '123 Main St' }
  end
end
