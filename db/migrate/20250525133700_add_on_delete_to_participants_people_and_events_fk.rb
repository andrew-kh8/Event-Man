class AddOnDeleteToParticipantsPeopleAndEventsFk < ActiveRecord::Migration[8.0]
  def change
    remove_foreign_key :participants, :people
    add_foreign_key :participants, :people, on_delete: :cascade, validate: false

    remove_foreign_key :participants, :events
    add_foreign_key :participants, :events, on_delete: :cascade, validate: false
  end
end
