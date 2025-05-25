class ValidateNotNullPersonFirstName < ActiveRecord::Migration[8.0]
  def up
    validate_check_constraint :people, name: "people_first_name_null"
    change_column_null :people, :first_name, false
    remove_check_constraint :people, name: "people_first_name_null"
  end

  def down
    add_check_constraint :people, "first_name IS NOT NULL", name: "people_first_name_null", validate: false, if_not_exists: true
    change_column_null :people, :first_name, true
  end
end
