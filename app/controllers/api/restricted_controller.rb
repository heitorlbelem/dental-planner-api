# frozen_string_literal: true

class Api::RestrictedController < ApplicationController
  before_action :authenticate_api_user!

  rescue_from Pundit::NotAuthorizedError, with: :resource_access_forbidden

  def current_user
    current_api_user
  end

  private

  def resource_access_forbidden
    render json: { errors: 'Unauthorized' }, status: :forbidden
  end
end
