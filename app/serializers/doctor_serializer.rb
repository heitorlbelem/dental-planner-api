# frozen_string_literal: true

class DoctorSerializer < ActiveModel::Serializer
  attributes :expertise

  belongs_to :user, sanitize: true
end
