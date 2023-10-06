class AvailableDriversChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'available_drivers_channel'
  end

  def unsubscribed
    stop_all_streams
  end

  def ask_for_available_drivers
    ActionCable.server.broadcast('available_drivers_channel', 'sendCoordinates')
  end

  def send_data(data)
    data = data['info']
    ActionCable.server.broadcast('available_drivers_channel', data)
  end
end
