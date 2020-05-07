class MeasurementChannel < ApplicationCable::Channel
  def subscribed
    stream_from "measurements_channel_#{current_user.id}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    raise NotImplementedError
  end
end
