FactoryBot.define do
  factory :treatment do
    status { 'pending' }
    patient { nil }
  end
end
