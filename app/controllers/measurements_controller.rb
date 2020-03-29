class MeasurementsController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :authenticate_user!, only: :create
  before_action :set_measurement, only: [:show, :update, :destroy]
  before_action :find_or_create_device, only: :create

  # GET /measurements
  def index
    @measurements = Measurement.select("
      measurements.*, 
      devices.name AS device_name
    ")
      .joins(:device).order("id DESC").limit(10)

    render json: @measurements
  end

  # GET /measurements/1
  def show
    render json: @measurement
  end

  # POST /measurements
  def create
    @measurement = @device.create_measurement(measurement_params)

    if @measurement.present?
      render json: @measurement, status: :created
    else
      render json: @measurement.errors, status: :unprocessable_entity
    end
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_measurement
      @measurement = Measurement.find(params[:id])
    end

    def find_or_create_device
      @device = Device.find_by(mac: params[:mac])

      if @device.nil?
        @device = Device.create!(
          mac: params[:mac],
          name: "Default"
        )
      end

      head(403) unless @device.authorized
    end

    # Only allow a trusted parameter "white list" through.
    def measurement_params
      params.permit(:opened, :device_id)
    end
end
