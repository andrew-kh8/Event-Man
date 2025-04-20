class CreateStarredOrganizations < ActiveRecord::Migration[8.0]
  def change
    create_table :starred_organizations do |t|
      t.belongs_to :person, null: false, foreign_key: true
      t.belongs_to :organization, null: false, foreign_key: true

      t.timestamps
    end
  end
end
