# frozen_string_literal: true

FactoryBot.define do
  factory :proceeding do
    appointment
    patient
    treatment
  end
end
