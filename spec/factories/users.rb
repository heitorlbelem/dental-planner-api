# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    username { Faker::Internet.username }
    email { Faker::Internet.email(name: first_name) }
    password { Faker::Internet.password }

    trait :confirmed do
      confirmed_at { Time.zone.now }
    end
  end
end
