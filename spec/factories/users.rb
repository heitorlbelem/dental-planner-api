# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email(name: first_name) }
    confirmed_at { Time.zone.now }
    encrypted_password { 'foobar123' }

    trait :unconfirmed do
      confirmed_at { nil }
    end

    trait :with_username do
      username { Faker::Internet.username(separators: ['-']) }
    end

    trait :admin do
      role { 'admin' }
    end
  end
end
