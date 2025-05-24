require 'rails_helper'

RSpec.describe Person, type: :model do
  subject(:person) { FactoryBot.build(:person) }

  # validations
  it { is_expected.to validate_presence_of(:first_name) }

  # associations
  it {
    expect(person).to have_many(:followers)
      .class_name('Friendship')
      .with_foreign_key('author_id')
      .inverse_of(:author)
      .dependent(:destroy)
  }

  it {
    expect(person).to have_many(:following)
      .class_name('Friendship')
      .with_foreign_key('follower_id')
      .inverse_of(:follower)
      .dependent(:destroy)
  }

  it { is_expected.to have_many(:followers_people).through(:followers).source(:author) }
  it { is_expected.to have_many(:following_people).through(:following).source(:follower) }

  it { is_expected.to have_many(:participants).dependent(:destroy_async) }
  it { is_expected.to have_many(:events).through(:participants) }

  it { is_expected.to have_many(:notifications).dependent(:destroy_async) }
  it { is_expected.to have_many(:authored_notifications).dependent(:nullify).class_name('Notification') }
  it { is_expected.to have_many(:notice_targets).dependent(:nullify).class_name('Notification') }

  it { is_expected.to have_many(:starred_organizations).dependent(:destroy) }
end
