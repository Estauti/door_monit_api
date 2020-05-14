class DevicesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_device, only: [:show, :update, :destroy, :alerts]

  # GET /devices
  def index
    @devices = Device.select("
      devices.*,
      measurements.opened
    ")
    .joins("LEFT JOIN (
        SELECT 
          device_id,
          MAX(id) AS id
        FROM measurements
        GROUP BY device_id
      ) AS last_measurement ON last_measurement.device_id = devices.id")
    .joins("LEFT JOIN measurements ON measurements.id = last_measurement.id")
    .where("devices.user_id = ?", current_user.id)
    .order("devices.name")

    render json: @devices, status: :ok
  end

  # GET /devices/1
  def show
    render json: @device
  end

  # PATCH/PUT /devices/1
  def update
    if @device.update(device_params)
      render json: @device
    else
      render json: @device.errors, status: :unprocessable_entity
    end
  end

  # DELETE /devices/1
  def destroy
    @device.destroy
  end

  def alerts
    render json: @device.alerts.order("alerts.id DESC").limit(5), status: :ok
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_device
      @device = Device.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def device_params
      params.require(:device).permit(:mac, :name, :in_alert, :authorized)
    end
end
