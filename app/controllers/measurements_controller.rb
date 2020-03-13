class MeasurementsController < ApplicationController
  before_action :set_measurement, only: [:show, :update, :destroy]

  # GET /measurements
  def index
    @measurements = Measurement.all

    render json: @measurements
  end

  # GET /measurements/1
  def show
    render json: @measurement
  end

  # POST /measurements
  def create
    device = Device.find_by(mac: params[:mac])
    if device.nil?
      device = Device.create!(
        mac: params[:mac],
        name: "Default"
      )
    end

    if device.authorized
      @measurement = device.create_measurement(measurement_params)

      if @measurement.present?
        render json: @measurement, status: :created
      else
        render json: @measurement.errors, status: :unprocessable_entity
      end

    else
      head(401)
    end

    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_measurement
      @measurement = Measurement.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def measurement_params
      params.require(:measurement).permit(:open, :device_id)
    end
end
