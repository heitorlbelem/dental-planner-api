# frozen_string_literal: true

FactoryBot.define do
  factory :block, class: 'Event::Block' do
    doctor
    start_time { 1.hour.from_now }
    end_time { 2.hours.from_now }
  end
end
