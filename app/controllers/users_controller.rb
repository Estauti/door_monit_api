class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def refresh
    render json: [], status: :ok
  end

  def get_by_token
    if current_user.present?
      user = current_user
      
      render json: user
    else
      render json: [], status: :unprocessable_entity
    end
  end
end
