# frozen_string_literal: true

FactoryBot.define do
  factory :address do
    zip_code { Faker::Address.zip_code }
    full_name { Faker::Address.full_address }
    complement { Faker::Address.secondary_address }
    neighborhood { Faker::Address.community }
    state { Faker::Address.state }
    city { Faker::Address.city }
  end
end
