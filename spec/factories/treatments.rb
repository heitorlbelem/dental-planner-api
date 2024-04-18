# frozen_string_literal: true

FactoryBot.define do
  factory :treatment do
    status { 'pending' }
    patient { nil }
  end
end
