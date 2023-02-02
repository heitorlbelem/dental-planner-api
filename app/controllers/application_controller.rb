# frozen_string_literal: true

class ApplicationController < ActionController::API
  before_action :configure_permitted_parameters, if: :devise_controller?

  def current_user
    current_api_user
  end

  def render_errors(object, status: :unprocessable_entity)
    render 'api/errors', locals: { errors: object.full_messages }, status: status
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit :sign_in, keys: %i[login password]
  end
end
