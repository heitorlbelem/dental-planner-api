# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    default_price { '9.99' }
    name { 'MyString' }
  end
end
