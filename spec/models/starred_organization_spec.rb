require 'rails_helper'

RSpec.describe StarredOrganization, type: :model do
  before { FactoryBot.create(:starred_organization) }

  # validations
  it { is_expected.to validate_uniqueness_of(:person_id).scoped_to(:organization_id) }

  # associations
  it { is_expected.to belong_to :person }
  it { is_expected.to belong_to :organization }
end
