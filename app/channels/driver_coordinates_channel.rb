class DriverCoordinatesChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'driver_coordinates_channel'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def get_driver_coordinates
    ActionCable.server.broadcast('driver_coordinates_channel', 'sendCoordinates')
  end

  def send_coordinates(data)
    coords = data['coords']
    ActionCable.server.broadcast('driver_coordinates_channel', coords)
  end

  def new_travel(data)
    travel_info = data['info']
    ActionCable.server.broadcast('driver_coordinates_channel', travel_info)
  end

  def confirm_travel(data)
    ActionCable.server.broadcast('driver_coordinates_channel', data)
  end

  def arrived(data)
    ActionCable.server.broadcast('driver_coordinates_channel', data)
  end

  def driver_coords(data)
    ActionCable.server.broadcast('driver_coordinates_channel', data)
  end

  def finish_trip(data)
    ActionCable.server.broadcast('driver_coordinates_channel', data)
  end
end
