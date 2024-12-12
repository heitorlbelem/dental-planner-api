# frozen_string_literal: true

json.extract! event, :id, :type, :start_time, :end_time, :doctor_id, :patient_id,
  :description
