class CreateNewTrip < BiizAction::Base
  params do
    param :passenger_id
    param :vehicle_id
    param :trip_attributes
  end

  def execute
    passenger = Passenger.find_by(id: passenger_id)
    vehicle = Vehicle.find_by(id: vehicle_id)

    return errors.add(:trip, 'Pasajero no existe.') unless passenger
    return errors.add(:trip, 'Vehículo no existe.') unless vehicle

    driver = vehicle.driver
    trip_attributes[:passenger_id] = passenger_id
    trip_attributes[:vehicle_id] = vehicle_id
    trip_attributes[:driver_id] = driver.id
    trip = Trip.new(trip_attributes)
    trip.save!
    trip
  end
end