class Device < ApplicationRecord
  has_many :measurements, dependent: :destroy
  has_many :alerts, dependent: :destroy
  belongs_to :user

  def create_measurement(params)
    m = Measurement.create!(params.merge(device_id: id))

    if m.present?
      ActionCable.server.broadcast("measurement_channel:#{user.id}", {device_id: id, opened: params[:opened]})
    end
    return m
  end

  def allowed_to_send_email?
    in_alert && can_send_another_email?
  end

  def can_send_another_email?
    return true if last_email_sent_at.nil?
    
    last_email_sent_at < 5.minutes.ago
  end
end
