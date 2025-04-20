class AddAcceptedToParticipants < ActiveRecord::Migration[8.0]
  def change
    add_column :participants, :accepted, :boolean, null: false, default: true
  end
end
