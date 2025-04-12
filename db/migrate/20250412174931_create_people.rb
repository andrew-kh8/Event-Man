class CreatePeople < ActiveRecord::Migration[8.0]
  def change
    create_table :people do |t|
      t.string :first_name
      t.string :last_name
      t.string :avatar
      t.date :birthday
      t.text :description
      t.string :city

      t.timestamps
    end
  end
end
