class ValidateChangeOrganizationsNameNullConstraint < ActiveRecord::Migration[8.0]
  def up
    validate_check_constraint :organizations, name: "organizations_name_null"
    change_column_null :organizations, :name, false
    remove_check_constraint :organizations, name: "organizations_name_null"
  end

  def down
    add_check_constraint :organizations, "name IS NOT NULL", name: "organizations_name_null", validate: false, if_not_exists: true
    change_column_null :organizations, :name, true
  end
end
