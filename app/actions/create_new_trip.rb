class CreateNewTrip < BiizAction::Base
  params do
    param :passenger_id
    param :driver_id
    param :vehicle_id
    param :trip_attributes
  end

  def execute
    passenger = Passenger.find(passenger_id:)
    driver = Driver.find(driver_id:)
    vehicle = Vehicle.find(vehicle_id:)

    return errors.add(:passenger, 'Pasajero no Existe.') unless passenger
    return errors.add(:driver, 'Conductor no Existe.') unless driver
    return errors.add(:vehicle, 'Vehiculo no Existe.') unless vehicle

    trip_attributes[:passenger] = passenger
    trip_attributes[:driver] = driver
    trip_attributes[:vehicle] = vehicle
    trip = Trip.new(trip_attributes)

    if trip.save
      trip
    else
      errors.add(:trip, trip.errors.full_messages.join(', '))
      nil
    end
  end
end
