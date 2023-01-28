# frozen_string_literal: true

class ApplicationController < ActionController::API
  def render_errors(object, status: :unprocessable_entity)
    render 'api/errors', locals: { errors: object.full_messages }, status: status
  end
end
