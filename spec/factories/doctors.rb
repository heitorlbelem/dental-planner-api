# frozen_string_literal: true

FactoryBot.define do
  factory :doctor do
    expertise { %w[generalista bucomaxilo].sample }
  end
end
