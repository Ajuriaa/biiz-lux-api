class Inputs::VehicleInputType < Types::BaseInputObject
  description 'Attributes to create a vehicle.'
  argument :vehicle_type, String, required: true
  argument :model, String, required: true
  argument :plate, String, required: true
  argument :year, Integer, required: true
  argument :color, String, required: true
  argument :registration, String, required: true
  argument :registration_expiration_date, String, required: true
end
