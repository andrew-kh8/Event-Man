require 'rails_helper'

RSpec.describe Event, type: :model do
  # validations
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :start_date }
  it { is_expected.to validate_presence_of :end_date }

  # associations
  it { is_expected.to belong_to :organization }
  it { is_expected.to have_many :participants }
  it { is_expected.to have_many :people }
  it { is_expected.to have_many :notice_targets }
end
