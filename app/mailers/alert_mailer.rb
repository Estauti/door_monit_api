class AlertMailer < ApplicationMailer
  default from: 'door.monit@gmail.com'

  def door_opened(device_id)
    @device = Device.find(device_id)
    @user = User.find(params[:user_id])

    @device.update_columns(last_email_sent_at: Time.now)

    mail(to: @user.email, subject: "#{@device.name} was opened")
  end

  # def door_closed
  # end
end
