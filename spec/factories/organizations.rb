FactoryBot.define do
  factory :organization do
    name { FFaker::Company.name }
    description { FFaker::Lorem.paragraph }
    email { FFaker::Internet.email }
    password { FFaker::Internet.password }
  end
end
