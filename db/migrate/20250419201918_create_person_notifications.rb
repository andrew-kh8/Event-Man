class CreatePersonNotifications < ActiveRecord::Migration[8.0]
  def up
    create_enum :author_types, ["Person", "Organization"]

    create_table :notifications do |t|
      t.belongs_to :person
      t.string :text, null: false
      t.boolean :read, null: false, default: false

      t.enum :author_type, enum_type: :author_types
      t.bigint :author_id

      t.timestamps
    end

    add_index :notifications, [:author_id, :author_type]
  end

  def down
    drop_table :notifications

    execute <<-SQL
      DROP TYPE author_types;
    SQL
  end
end
