class AddOnDeleteToNotificationsPeopleFk < ActiveRecord::Migration[8.0]
  def change
    remove_foreign_key :notifications, :people
    add_foreign_key :notifications, :people, on_delete: :cascade, validate: false
  end
end
