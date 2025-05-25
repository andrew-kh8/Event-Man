class ChangeNotificationsNullConstraint < ActiveRecord::Migration[8.0]
  def change
    add_check_constraint :notifications, "target_type IS NOT NULL", name: "notifications_target_type_null", validate: false
    add_check_constraint :notifications, "target_id IS NOT NULL", name: "notification_target_id_null", validate: false

    add_check_constraint :notifications, "author_type IS NOT NULL", name: "notifications_author_type_null", validate: false
    add_check_constraint :notifications, "author_id IS NOT NULL", name: "notifications_author_id_null", validate: false

    add_check_constraint :notifications, "person_id IS NOT NULL", name: "notifications_person_id_null", validate: false
  end
end
