class AddTargetToNotifications < ActiveRecord::Migration[8.0]
  def up
    create_enum :target_types, ["Person", "Event"]
    create_enum :types_of_notifications, ["info", "invite", "offer", "warning"]

    add_column :notifications, :target_type, :enum, enum_type: :target_types
    add_column :notifications, :target_id, :bigint
    add_column :notifications, :notice_type, :enum, enum_type: :types_of_notifications, null: false, default: "info"
  end

  def down
    remove_column :notifications, :target_type
    remove_column :notifications, :target_id
    remove_column :notifications, :notice_type

    execute <<-SQL
      DROP TYPE target_types;
      DROP TYPE types_of_notifications;
    SQL
  end
end
