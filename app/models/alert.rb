class Alert < ApplicationRecord
  belongs_to :device
  before_create :set_time_stamps
  before_save :set_time_stamps

  def finished?
    finished_at.present?
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
