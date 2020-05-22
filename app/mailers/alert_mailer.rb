class AlertMailer < ApplicationMailer
  default from: 'door.monit@gmail.com'

  def door_opened(device_id)
    @device = Device.find(device_id)
    @user = User.find(params[:user_id])
    @alert = @device.opened_alert

    @device.update_columns(last_email_sent_at: Time.now)

    attachments.inline['logo.png']  = File.read("#{Rails.root}/public/images/logo.png")
    mail(to: @user.email, subject: "#{@device.name} foi aberto(a)")
  end

  # def door_closed
  # end
end
