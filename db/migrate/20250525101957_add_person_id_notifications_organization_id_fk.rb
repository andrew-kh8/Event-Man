class AddPersonIdNotificationsOrganizationIdFk < ActiveRecord::Migration[8.0]
  def change
    add_foreign_key :notifications, :people, column: :person_id, primary_key: :id, validate: false
  end
end
