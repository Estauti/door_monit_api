class MeasurementChannel < ApplicationCable::Channel
  def subscribed
    stream_from "measurement_channel:#{params[:user_id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    # raise NotImplementedError
  end
end
