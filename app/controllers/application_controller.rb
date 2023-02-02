# frozen_string_literal: true

class ApplicationController < ActionController::API
  include Pundit::Authorization

  before_action :configure_permitted_parameters, if: :devise_controller?

  def render_errors(object, status: :unprocessable_entity)
    render 'api/errors', locals: { errors: object.full_messages }, status: status
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit :sign_in, keys: %i[login password]
  end
end
