FactoryBot.define do
  factory :event do
    organization

    name { FFaker::SportUS.name }
    description { FFaker::Lorem.paragraph }
    start_date { DateTime.new(2025, 5, 1, 20, 33) }
    end_date { DateTime.new(2025, 5, 1, 22) }
  end
end
