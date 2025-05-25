class ValidatePeopleIdNotificationsPersonIdFk < ActiveRecord::Migration[8.0]
  def change
    validate_foreign_key :notifications, :people
  end
end
