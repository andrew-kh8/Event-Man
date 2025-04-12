class CreateEvents < ActiveRecord::Migration[8.0]
  def change
    create_table :events do |t|
      t.string :name, null: false
      t.text :description
      t.string :image
      t.datetime :start_date, null: false
      t.datetime :end_date, null: false

      t.belongs_to :organization

      t.timestamps
    end
  end
end
