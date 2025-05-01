FactoryBot.define do
  factory :event do
    name { "qwe" }
    description { "desc" }
    start_date { 1.week.ago }
    end_date { Date.today}
    organization_id { Organization.ids.sample }
  end
end
