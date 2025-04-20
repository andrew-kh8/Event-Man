class StarredOrganization < ApplicationRecord
  belongs_to :person
  belongs_to :organization

  validates :person_id, uniqueness: { scope: :organization_id }
end
