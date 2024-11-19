# frozen_string_literal: true

FactoryBot.define do
  factory :appointment, class: 'Event::Appointment' do
    doctor
    patient
    start_time { 1.hour.from_now }
    duration { 20 }
  end
end
