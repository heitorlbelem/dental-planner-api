# frozen_string_literal: true

class ApplicationController < ActionController::API
  rescue_from Pundit::NotAuthorizedError, with: :resource_access_forbidden

  def render_errors(object, status: :unprocessable_entity)
    render json: object, status: status,
      serializer: ActiveModel::Serializer::ErrorSerializer
  end

  private

  def resource_access_forbidden
    render json: { errors: 'Unauthorized' }, status: :forbidden
  end
end
