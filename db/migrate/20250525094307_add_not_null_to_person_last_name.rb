class AddNotNullToPersonLastName < ActiveRecord::Migration[8.0]
  def change
    Person.where(last_name: nil).update_all(last_name: "Не Указано")

    add_check_constraint :people, "last_name IS NOT NULL", name: "people_last_name_null", validate: false
  end
end
