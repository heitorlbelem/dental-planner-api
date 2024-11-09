# frozen_string_literal: true

FactoryBot.define do
  Faker::Config.locale = 'pt-BR'

  factory :doctor do
    name { Faker::Name.name }
    expertise { %w[generalista bucomaxilo].sample }
  end
end
