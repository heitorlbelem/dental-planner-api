# frozen_string_literal: true

class PatientSerializer < ActiveModel::Serializer
  attributes :name, :phone, :email, :cpf, :birthdate, :created_at, :updated_at
end
