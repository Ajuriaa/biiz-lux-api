class CreateNewVehicle < BiizAction::Base
  params do
    param :driver_id
    param :vehicle_attributes
  end

  def execute
    existing_driver = Driver.exists?(id: driver_id)
    expiration_date = vehicle_attributes[:registration_expiration_date].to_date

    return errors.add(:vehicle, 'Conductor no existe.') unless existing_driver
    return errors.add(:vehicle, 'Fecha de registro tiene que ser vigente.') if expiration_date < Time.zone.now

    vehicle_attributes[:driver_id] = driver_id
    vehicle = Vehicle.new(vehicle_attributes)
    vehicle.save!
    vehicle
  end
end
