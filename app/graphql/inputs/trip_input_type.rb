class Inputs::TripInputType < Types::BaseInputObject
  description 'Attributes to create a trip.'
  argument :start_location_id, Types::LocationType, 'trip start location', required: true
  argument :end_location_id, Types::LocationType, 'trip end location', required: true
  argument :start_time, String, 'trip start time', required: true
  argument :end_time, String, 'trip end time', required: false
  argument :distance, Float, 'trip distance', required: true
  argument :fare, String, 'trip fare', required: true
  argument :status, String, 'trip status', required: true
end
