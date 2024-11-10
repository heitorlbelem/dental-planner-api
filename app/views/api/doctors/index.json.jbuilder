# frozen_string_literal: true

json.doctors @doctors do |doctor|
  json.partial! 'doctor', doctor:
end
