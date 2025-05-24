FactoryBot.define do
  factory :friendship do
    author { create(:person) }
    follower { create(:person) }
  end
end
