class ValidateOrganizationsIdEventsOrganizationIdFk < ActiveRecord::Migration[8.0]
  def change
    validate_foreign_key :events, :organizations
  end
end
