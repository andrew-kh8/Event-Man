class ChangeOrganizationsNameNullConstraint < ActiveRecord::Migration[8.0]
  def change
    add_check_constraint :organizations, "name IS NOT NULL", name: "organizations_name_null", validate: false
  end
end
