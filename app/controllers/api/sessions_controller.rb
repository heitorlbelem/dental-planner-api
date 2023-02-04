# frozen_string_literal: true

class Api::SessionsController < Devise::SessionsController
  before_action :configure_permitted_parameters

  respond_to :json

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit :sign_in, keys: %i[login password]
  end

  private

  def respond_with(_resource, _opts = {})
    render json: current_api_user, status: :ok
  end

  def respond_to_on_destroy
    current_api_user ? log_out_success : log_out_failure
  end

  def log_out_success
    render json: { message: 'Logged out.' }, status: :ok
  end

  def log_out_failure
    render json: { message: 'Logged out failure.' }, status: :unauthorized
  end
end
