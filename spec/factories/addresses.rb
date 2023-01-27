# frozen_string_literal: true

FactoryBot.define do
  factory :address do
    zip_code { Faker::Address.zip_code }
    street { Faker::Address.street_name }
    number { Faker::Address.building_number }
    neighborhood { Faker::Address.community }
    state { Faker::Address.state }
    city { Faker::Address.city }
    complement { Faker::Address.secondary_address }
  end
end
