40.times do
  random_cpf = CPF.generate
  Patient.create(
    name: Faker::Name.name,
    gender: ['female', 'male', 'other'].sample,
    date_of_birth: Faker::Date.birthday,
    email: Faker::Internet.email,
    phone: Faker::PhoneNumber.cell_phone,
    cpf: random_cpf
  )
end