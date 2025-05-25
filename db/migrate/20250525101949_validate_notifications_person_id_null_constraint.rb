class ValidateNotificationsPersonIdNullConstraint < ActiveRecord::Migration[8.0]
  def up
    validate_check_constraint :notifications, name: "notifications_person_id_null"

    change_column_null :notifications, :person_id, false

    remove_check_constraint :notifications, name: "notifications_person_id_null"
  end

  def down
    add_check_constraint :notifications, "person_id IS NOT NULL", name: "notifications_person_id_null", validate: false, if_not_exists: true

    change_column_null :notifications, :person_id, true
  end
end
