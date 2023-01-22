# frozen_string_literal: true

module Request
  module JsonHelpers
    def json
      @json ||= JSON.parse(response.body, symbolize_names: true)
    end
  end
end
