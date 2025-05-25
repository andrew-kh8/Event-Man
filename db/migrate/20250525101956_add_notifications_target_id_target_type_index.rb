class AddNotificationsTargetIdTargetTypeIndex < ActiveRecord::Migration[8.0]
  disable_ddl_transaction!

  def change
    add_index :notifications, [:target_id, :target_type], algorithm: :concurrently
  end
end
