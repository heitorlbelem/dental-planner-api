# frozen_string_literal: true

FactoryBot.define do
  factory :privilege do
    user { nil }
    claim { nil }
  end
end