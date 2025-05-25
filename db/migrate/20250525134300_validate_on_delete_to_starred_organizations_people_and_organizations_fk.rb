class ValidateOnDeleteToStarredOrganizationsPeopleAndOrganizationsFk < ActiveRecord::Migration[8.0]
  def change
    validate_foreign_key :starred_organizations, :people
    validate_foreign_key :starred_organizations, :organizations
  end
end
