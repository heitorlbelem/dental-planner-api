# frozen_string_literal: true

FactoryBot.define do
  factory :appointment do
    doctor
    patient
  end
end
