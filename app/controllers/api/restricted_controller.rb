# frozen_string_literal: true

class Api::RestrictedController < ApplicationController
  before_action :authenticate_api_user!
  before_action :check_permission!

  private

  def check_permission!
    current_user.check_permission(claim_name)
  end

  def claim_name
    "#{action_name}_#{controller_name}"
  end
end
