class MeasurementsController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :authenticate_user!, only: :create
  before_action :set_measurement, only: [:show, :update, :destroy]
  before_action :find_or_create_device, only: :create
  after_action :send_alert_email, only: :create

  # GET /measurements
  def index
    @measurements = Measurement.select("
      measurements.*, 
      devices.name AS device_name
    ")
      .joins(:device).order("id DESC").limit(10)
      .where("devices.user_id = ?", current_user.id)

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

      user = validate_device_owner
      head(401) if user.nil?

      if @device.nil?
        @device = Device.create!(
          mac: params[:mac],
          name: params[:name],
          user_id: user.id
        )
      end

      head(403) unless @device.authorized
    end

    def validate_device_owner
      user = User.find_by(email: params[:email])

      return nil if user.nil?
      return nil unless user.valid_password?(params[:password])
      return user unless @device.present?
      return nil if user.id != @device.user_id

      return user
    end

    # Only allow a trusted parameter "white list" through.
    def measurement_params
      params.permit(:opened, :device_id)
    end

    def send_alert_email
      return unless @device.allowed_to_send_email? && @measurement.opened

      AlertMailer.with(user_id: @device.user_id).door_opened(@device.id).deliver_later
    end
end
