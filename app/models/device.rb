class Device < ApplicationRecord
  has_many :measurements, dependent: :destroy
  belongs_to :user

  def create_measurement(params)
    m = Measurement.create!(params.merge(device_id: id))

    if m.present?
      MeasurementChannel.broadcast("measurements_channel_#{user.id}", {msg: "criou medição"})
    end
  end
end
