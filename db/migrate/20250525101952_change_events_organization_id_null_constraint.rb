class ChangeEventsOrganizationIdNullConstraint < ActiveRecord::Migration[8.0]
  def change
    add_check_constraint :events, "organization_id IS NOT NULL", name: "events_organization_id_null", validate: false
  end
end
