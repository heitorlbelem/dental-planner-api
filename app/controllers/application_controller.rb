# frozen_string_literal: true

class ApplicationController < ActionController::API
  rescue_from Pundit::NotAuthorizedError, with: :resource_access_forbidden

  def render_errors(object, status: :unprocessable_entity)
    render 'api/errors', locals: { errors: object.full_messages }, status: status
  end

  private

  def resource_access_forbidden
    render json: { errors: 'Unauthorized' }, status: :forbidden
  end
end
