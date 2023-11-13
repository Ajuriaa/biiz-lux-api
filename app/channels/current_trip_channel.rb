class CurrentTripChannel < ApplicationCable::Channel
  def subscribed
    stream_from "current_trip_#{params['trip_id']}"
  end

  def unsubscribed
    stop_all_streams
  end

  def send_data(data)
    info = data['info']
    ActionCable.server.broadcast("current_trip_#{data['trip_id']}", info)
  end
end
