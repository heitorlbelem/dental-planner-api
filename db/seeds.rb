# frozen_string_literal: true

10.times do
  Doctor.create!(
    name: Faker::Name.name,
    expertise: %w[protesist orthodontist endodontist pediatric periodontist].sample
  )
end

10.times do
  Patient.create!(
    name: Faker::Name.name,
    gender: ['male', 'female', 'other'].sample,
    date_of_birth: Faker::Date.birthday(min_age: 18, max_age: 65),
    email: Faker::Internet.email,
    phone: Faker::PhoneNumber.cell_phone,
    cpf: CPF.generate
  )
end


