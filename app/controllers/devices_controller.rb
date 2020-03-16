class DevicesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_device, only: [:show, :update, :destroy]

  # GET /devices
  def index
    @devices = Device.select("
      devices.*,
      last_measurement.opened
    ")
    .joins("LEFT JOIN (
        SELECT 
          id, 
          device_id,
          opened
        FROM measurements
        ORDER BY id DESC
        LIMIT 1
      ) AS last_measurement ON last_measurement.device_id = devices.id")
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_device
      @device = Device.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def device_params
      params.require(:device).permit(:mac, :name, :active, :authorized)
    end
end
