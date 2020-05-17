class AlertChannel < ApplicationCable::Channel
  def subscribed
    stream_from "alert_channel:#{params[:user_id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    # raise NotImplementedError
  end
end
