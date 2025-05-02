FactoryBot.define do
  factory :notification do
    person

    text { FFaker::Lorem.sentence }
  end
end
