# frozen_string_literal: true

json.patient do
  json.partial! 'patient', locals: { patient: @patient }
end
