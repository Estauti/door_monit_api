class AlertsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_alert, only: :show

  def index
    @alerts = current_user.alerts
      .select("
        alerts.*,
        devices.name AS device_name
      ")
      .joins(:device)
      .order("alerts.started_at DESC")

    if params[:device_id].present?
      @alerts = @alerts.where(device_id: params[:device_id])
    end

    @pagy, @alerts = pagy(@alerts, page: params[:page], items: 5)
    response.set_header('Total-Pages', @pagy.pages)

    render json: @alerts, status: :ok
  end

  private

  def set_alert
    @alert = Alert.find(params[:id])
  end
end
