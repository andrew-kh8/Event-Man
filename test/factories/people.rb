FactoryBot.define do
  factory :person do
    first_name { "MyString" }
    last_name { "MyString" }
    birthday { "2025-04-12" }
    description { "MyText" }
    city { "MyString" }
  end
end
