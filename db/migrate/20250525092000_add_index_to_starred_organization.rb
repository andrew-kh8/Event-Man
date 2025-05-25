class AddIndexToStarredOrganization < ActiveRecord::Migration[8.0]
  disable_ddl_transaction!

  def change
    add_index :starred_organizations, [:person_id, :organization_id], unique: true, algorithm: :concurrently
    remove_index :starred_organizations, :person_id
  end
end
