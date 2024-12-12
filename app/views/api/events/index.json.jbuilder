# frozen_string_literal: true

json.events @events do |event|
  json.partial! 'event', event:
end
