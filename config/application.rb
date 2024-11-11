# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module DentalPlannerApi
  class Application < Rails::Application
    config.load_defaults 7.0
    config.api_only = true
    config.generators do |generator|
      generator.test_framework :rspec, fixture: false
      generator.controller_specs = false
      generator.helper_specs = false
      generator.model_specs = true
      generator.routing_specs = false
      generator.request_specs = false
      generator.view_specs = false
    end
  end
end
