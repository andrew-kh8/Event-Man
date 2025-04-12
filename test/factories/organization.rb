FactoryBot.define do
  factory :organization do
    name { "qwe" }
    description { "desc" }
    sequence(:email) { |n| "email#{n}@email.test" }
    password { "email@email.test" }
  end
end
