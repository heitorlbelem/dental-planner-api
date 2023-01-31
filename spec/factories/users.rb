# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    username { Faker::Internet.username }
    email { Faker::Internet.email(name: name) }
    cpf { Faker::IDNumber.brazilian_citizen_number }

    trait :confirmed_user do
      confirmed_at { Time.zone.now }
    end
  end
end
