class Inputs::LocationInputType < Types::BaseInputObject
  description 'Attributes for a location.'
  argument :latitude, String, 'location latitude', required: true
  argument :longitude, String, 'location longitude', required: true
end
