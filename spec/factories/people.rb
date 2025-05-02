FactoryBot.define do
  factory :person do
    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }
    birthday { FFaker::Date.birthday }
    description { FFaker::Lorem.sentence }
    city { FFaker::Address.city }

    email { FFaker::Internet.email }
    password { FFaker::Internet.password }
  end
end
