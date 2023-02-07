# frozen_string_literal: true

class ApplicationController < ActionController::API
  include ErrorSerializer

  rescue_from Pundit::NotAuthorizedError, with: :resource_access_forbidden

  def render_errors(entity, status: :unprocessable_entity)
    render json: ErrorSerializer.serialize(entity, status), status: status
  end

  def permit_params(only:)
    ActiveModelSerializers::Deserialization.jsonapi_parse(
      params, only: only
    )
  end

  private

  def resource_access_forbidden
    render json: { errors: 'Unauthorized' }, status: :forbidden
  end
end
