class Device < ApplicationRecord
  has_many :measurements, dependent: :destroy
  belongs_to :user

  def create_measurement(params)
    Measurement.create!(params.merge(device_id: self.id))
  end
end
