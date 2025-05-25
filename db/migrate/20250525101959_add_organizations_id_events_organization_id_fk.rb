class AddOrganizationsIdEventsOrganizationIdFk < ActiveRecord::Migration[8.0]
  def change
    add_foreign_key :events, :organizations, column: :organization_id, primary_key: :id, validate: false
  end
end
