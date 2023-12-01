class FareAlgorithm < BiizAction::Base
  params do
    param :car_weight
    param :trip_time
    param :phone_battery
    param :driver_availability
    param :distance
    param :estimated_arrival_time
  end

  def execute
    # Base fare
    base_fare = 5.5

    # Factor based on car weight
    car_weight_factor = car_weight / 10.0

    # Factor based on time of the day
    time_factor = calculate_time_factor(trip_time)

    # Factor based on phone battery
    battery_factor = calculate_battery_factor(phone_battery)

    # Factor based on driver availability
    availability_factor = calculate_availability_factor(driver_availability)

    # Distance factor (assuming a simple distance-based calculation in ms)
    distance_factor = (distance / 1000) * 2.0

    # Factor based on estimated arrival time
    arrival_time_factor = calculate_arrival_time_factor(estimated_arrival_time)

    # Calculate the total fare
    car_fare = base_fare * car_weight_factor
    time_fare = base_fare * time_factor
    battery_fare = base_fare * battery_factor
    availability_fare = base_fare * availability_factor
    distance_fare = base_fare * distance_factor
    arrival_fare = base_fare * arrival_time_factor

    total_fare = base_fare + car_fare + time_fare + battery_fare + availability_fare + distance_fare + arrival_fare
    # You may round the total fare to two decimal places
    total_fare.round(2)
  end

  private

  def calculate_time_factor(trip_time)
    # Not accounting traffic data, just time of the day
    if trip_time.hour >= 0 && trip_time.hour < 6
      1.5
    elsif trip_time.hour >= 17 && trip_time.hour < 23
      1.2
    else
      1.0
    end
  end

  def calculate_battery_factor(phone_battery)
    # Based on phone battery percentage
    phone_battery < 20 ? 2.0 : 1.0
  end

  def calculate_availability_factor(driver_availability)
    # Based on the driver count at the moment of the trip
    driver_availability < 10 ? 2.0 : 1.0
  end

  def calculate_arrival_time_factor(estimated_arrival_time)
    # Factor based on estimated arrival time in minutes
    # Adjust the logic based on your specific requirements
    if estimated_arrival_time > 1800
      1.5
    elsif estimated_arrival_time > 900
      1.2
    else
      1.0
    end
  end
end
