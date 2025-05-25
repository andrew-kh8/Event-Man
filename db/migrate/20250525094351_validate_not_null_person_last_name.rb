class ValidateNotNullPersonLastName < ActiveRecord::Migration[8.0]
  def up
    validate_check_constraint :people, name: "people_last_name_null"
    change_column_null :people, :last_name, false
    remove_check_constraint :people, name: "people_last_name_null"
  end

  def down
    add_check_constraint :people, "last_name IS NOT NULL", name: "people_last_name_null", validate: false, if_not_exists: true
    change_column_null :people, :last_name, true
  end
end
