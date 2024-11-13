# frozen_string_literal: true

json.patients @patients do |patient|
  json.partial! 'patient', patient:
end
