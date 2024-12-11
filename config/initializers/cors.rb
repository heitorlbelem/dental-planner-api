# frozen_string_literal: true

# Avoid CORS issues when API is called from the frontend app.
# Handle Cross-Origin Resource Sharing (CORS) in order to accept cross-origin
# AJAX requests.

# Read more: https://github.com/cyu/rack-cors

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins ENV.fetch('CORS_ORIGIN', '*')

    resource 'http://localhost:3000', 'http://127.0.0.1:3000',
      headers: :any,
      methods: %i[get post put patch delete options head],
      credentials: true
  end
end
