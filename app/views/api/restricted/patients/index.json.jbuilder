# frozen_string_literal: true

json.patients do
  json.array! @patients do |patient|
    json.partial! 'patient', locals: { patient: patient }
  end
end
