class Inputs::TripInputType < Types::BaseInputObject
  description 'Attributes to create a trip.'
  argument :start_location, Inputs::LocationInputType, 'trip start location', required: true
  argument :end_location, Inputs::LocationInputType, 'trip end location', required: true
  argument :start_address, String, 'trip start address', required: true
  argument :end_address, String, 'trip end address', required: true
  argument :start_time, String, 'trip start time', required: true
  argument :distance, Float, 'trip distance', required: true
  argument :fare, Float, 'trip fare', required: true
  argument :status, String, 'trip status', required: true
end
