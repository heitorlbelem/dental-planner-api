# frozen_string_literal: true

json.address do
  json.extract! @address, :id, :patient_id, :zip_code, :street, :number, :neighborhood,
    :state, :city, :complement
end
