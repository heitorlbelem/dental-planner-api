# frozen_string_literal: true

class Api::RestrictedController < ApplicationController
  include Pundit::Authorization

  before_action :authenticate_api_user!

  def current_user
    current_api_user
  end
end
