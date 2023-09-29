class Inputs::LocationInputType < Types::BaseInputObject
  description 'Attributes for a location.'
  argument :lat, Float, 'location latitude', required: true
  argument :lng, Float, 'location longitude', required: true
end
