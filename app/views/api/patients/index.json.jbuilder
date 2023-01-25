# frozen_string_literal: true

json.patients do
  json.array! @patients do |patient|
    json.extract! patient, :name, :phone, :cpf, :email, :birthdate
  end
end
