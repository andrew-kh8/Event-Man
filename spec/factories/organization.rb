FactoryBot.define do
  factory :organization do
    name { FFaker::Company.name }
    description { FFaker::Lorem.paragraph }
    sequence(:email) { |n| "email#{n}@email.test" }
    password { "email@email.test" }
  end
end
