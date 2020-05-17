class ApplicationController < ActionController::API
  include Pagy::Backend
  
  before_action :configure_permitted_parameters, if:  :devise_controller?

  respond_to :json

  def render_resource(resource)
    if resource.errors.empty?
      render json: resource
    else
      validation_error(resource)
    end
  end

  def validation_error(resource)
    render json: {
      errors: [
        {
          status: '400',
          title: 'Bad Request',
          detail: resource.errors
        }
      ]
    }, status: :bad_request
  end

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    end
end
