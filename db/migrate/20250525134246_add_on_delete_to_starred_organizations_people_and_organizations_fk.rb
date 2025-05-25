class AddOnDeleteToStarredOrganizationsPeopleAndOrganizationsFk < ActiveRecord::Migration[8.0]
  def change
    remove_foreign_key :starred_organizations, :people
    add_foreign_key :starred_organizations, :people, on_delete: :cascade, validate: false

    remove_foreign_key :starred_organizations, :organizations
    add_foreign_key :starred_organizations, :organizations, on_delete: :cascade, validate: false
  end
end
