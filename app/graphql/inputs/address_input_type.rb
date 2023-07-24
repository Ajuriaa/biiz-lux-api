class Inputs::AddressInputType < Types::BaseInputObject
  description 'Attributes for a location.'
  argument :name, String, 'address custom name', required: true
  argument :latitude, String, 'address latitude', required: true
  argument :longitude, String, 'address longitude', required: true
  argument :primary, Boolean, 'address default status', required: true
  argument :address, String, 'address directions', required: true
end
