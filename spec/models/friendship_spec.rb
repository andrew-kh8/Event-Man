require 'rails_helper'

RSpec.describe Friendship, type: :model do
  # associations
  it { is_expected.to belong_to(:author).class_name('Person').inverse_of(:followers) }
  it { is_expected.to belong_to(:follower).class_name('Person').inverse_of(:following) }
  it { is_expected.to belong_to(:not_approved).class_name('Person').optional }
end
