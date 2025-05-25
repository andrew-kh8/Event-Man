class ValidateEventsOrganizationIdNullConstraint < ActiveRecord::Migration[8.0]
  CONSTRAINT_NAME = "events_organization_id_null"

  def up
    validate_check_constraint :events, name: CONSTRAINT_NAME

    change_column_null :events, :organization_id, false

    remove_check_constraint :events, name: CONSTRAINT_NAME
  end

  def down
    add_check_constraint :events, "organization_id IS NOT NULL", name: CONSTRAINT_NAME, validate: false, if_not_exists: true

    change_column_null :events, :organization_id, true
  end
end
