require 'rails_helper'

RSpec.describe Notification, type: :model do
  # associations
  it { is_expected.to belong_to :person }
  it { is_expected.to belong_to :author }
  it { is_expected.to belong_to :target }
end
