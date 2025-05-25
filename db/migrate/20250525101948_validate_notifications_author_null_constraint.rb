class ValidateNotificationsAuthorNullConstraint < ActiveRecord::Migration[8.0]
  def up
    validate_check_constraint :notifications, name: "notifications_author_type_null"
    validate_check_constraint :notifications, name: "notifications_author_id_null"

    change_column_null :notifications, :author_type, false
    change_column_null :notifications, :author_id, false

    remove_check_constraint :notifications, name: "notifications_author_type_null"
    remove_check_constraint :notifications, name: "notifications_author_id_null"
  end

  def down
    add_check_constraint :notifications, "author_type IS NOT NULL", name: "notifications_author_type_null", validate: false, if_not_exists: true
    add_check_constraint :notifications, "author_id IS NOT NULL", name: "notifications_author_id_null", validate: false, if_not_exists: true

    change_column_null :notifications, :author_type, true
    change_column_null :notifications, :author_id, true
  end
end
