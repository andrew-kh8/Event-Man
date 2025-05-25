class ValidateNotificationsTargetNullConstraint < ActiveRecord::Migration[8.0]
  def up
    validate_check_constraint :notifications, name: "notifications_target_type_null"
    validate_check_constraint :notifications, name: "notification_target_id_null"

    change_column_null :notifications, :target_type, false
    change_column_null :notifications, :target_id, false

    remove_check_constraint :notifications, name: "notifications_target_type_null"
    remove_check_constraint :notifications, name: "notification_target_id_null"
  end

  def down
    add_check_constraint :notifications, "target_type IS NOT NULL", name: "notifications_target_type_null", validate: false, if_not_exists: true
    add_check_constraint :notifications, "target_id IS NOT NULL", name: "notification_target_id_null", validate: false, if_not_exists: true

    change_column_null :notifications, :target_type, true
    change_column_null :notifications, :target_id, true
  end
end
