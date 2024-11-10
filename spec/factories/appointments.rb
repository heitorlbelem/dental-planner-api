# frozen_string_literal: true

FactoryBot.define do
  factory :appointment do
    doctor
    patient
    start_time { 1.day.from_now }
    duration_in_minutes { 30.minutes }
  end
end
