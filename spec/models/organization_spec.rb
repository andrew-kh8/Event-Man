require 'rails_helper'

RSpec.describe Organization, type: :model do
  # validations
  it { is_expected.to validate_presence_of :email }
  it { is_expected.to validate_presence_of :name }

  # associations
  it { is_expected.to have_many(:events).dependent(:destroy_async) }
  it { is_expected.to have_many(:authored_notifications).dependent(:nullify).class_name('Notification') }
  it { is_expected.to have_many(:starred_organizations).dependent(:destroy) }
end
