class Alert < ApplicationRecord
  belongs_to :device
  before_create :set_time_stamps
  before_save :set_time_stamps
  after_create :broadcast_creation
  after_update :broadcast_finish, Proc.new { finished? }

  def finished?
    finished_at.present?
  end

  def broadcast_creation
    ActionCable.server.broadcast("alert_channel:#{device.user.id}", {action: 'started'})
  end

  def broadcast_finish
    ActionCable.server.broadcast("alert_channel:#{device.user.id}", {
      action: 'finished',
      id: id,
      finished_at: finished_at
    })
  end

  private
  def set_time_stamps
    if self.new_record?
      self.started_at = Time.now 
    else
      self.finished_at = Time.now
    end
  end
end
