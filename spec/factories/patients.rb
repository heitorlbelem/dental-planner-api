# frozen_string_literal: true

FactoryBot.define do
  Faker::Config.locale = 'pt-BR'

  factory :patient do
    name { Faker::Name.name }
    phone { Faker::PhoneNumber.cell_phone }
    email { Faker::Internet.email(name: name) }
    cpf { Faker::IDNumber.brazilian_citizen_number(formatted: true) }
    address { Faker::Address.full_address }
  end
end
