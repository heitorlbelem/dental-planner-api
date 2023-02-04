# frozen_string_literal: true

class ApplicationController < ActionController::API
  include ErrorSerializer

  rescue_from ActiveRecord::RecordNotFound, with: -> { head :not_found }
  rescue_from Pundit::NotAuthorizedError, with: :resource_access_forbidden

  def render_errors(entity, status: :unprocessable_entity)
    render json: ErrorSerializer.serialize(entity, status), status: status
  end

  private

  def resource_access_forbidden
    render json: { errors: 'Unauthorized' }, status: :forbidden
  end
end
