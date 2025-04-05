class CreateOrganizations < ActiveRecord::Migration[8.0]
  def change
    create_table :organizations do |t|
      t.string :name
      t.text :description
      t.string :activity_field

      t.timestamps
    end
  end
end
