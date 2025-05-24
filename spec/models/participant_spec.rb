require 'rails_helper'

RSpec.describe Participant, type: :model do
  # validations
  it { is_expected.to define_enum_for(:visible).with_values(private: -1, normal: 0, public: 1).with_suffix }

  # associations
  it { is_expected.to belong_to :person }
  it { is_expected.to belong_to :event }
end
