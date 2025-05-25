class AddNotNullToPersonFirstName < ActiveRecord::Migration[8.0]
  def change
    Person.where(first_name: nil).update_all(first_name: "Не Указано")

    add_check_constraint :people, "first_name IS NOT NULL", name: "people_first_name_null", validate: false
  end
end
