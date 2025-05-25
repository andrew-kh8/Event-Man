class ValidateParticipantsPeopleAndEventsFk < ActiveRecord::Migration[8.0]
  def change
    validate_foreign_key :participants, :people
    validate_foreign_key :participants, :events
  end
end
