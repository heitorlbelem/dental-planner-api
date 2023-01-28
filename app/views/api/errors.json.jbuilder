# frozen_string_literal: true

json.errors do
  json.array! errors do |error|
    json.message error
  end
end
