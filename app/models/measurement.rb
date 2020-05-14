class Measurement < ApplicationRecord
  belongs_to :device
  after_create :create_alert
  after_create :finish_alert

  def create_alert
    return unless device.in_alert && opened

    last_alert = device.alerts.last

    if last_alert.nil? || last_alert.finished?
      Alert.create(device: device)
    end
  end

  def finish_alert
    return unless device.in_alert && !opened

    last_alert = device.alerts.last

    unless last_alert.finished?
      last_alert.update(finished_at: Time.now)
    end
  end
end
