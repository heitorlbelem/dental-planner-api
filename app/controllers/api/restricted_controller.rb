# frozen_string_literal: true

class Api::RestrictedController < ApplicationController
  before_action :authenticate_api_user!
end
