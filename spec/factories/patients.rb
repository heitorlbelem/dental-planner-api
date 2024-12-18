# frozen_string_literal: true

FactoryBot.define do
  Faker::Config.locale = 'pt-BR'

  factory :patient do
    name { Faker::Name.name }
    phone { Faker::PhoneNumber.cell_phone }
    email { Faker::Internet.email(name:) }
    cpf { Faker::IdNumber.brazilian_citizen_number }
    gender { %w[male female other].sample }
    date_of_birth { Faker::Date.birthday }
  end
end
