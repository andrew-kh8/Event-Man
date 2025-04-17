class AddVisibleToParticipants < ActiveRecord::Migration[8.0]
  def change
    add_column :participants, :visible, :integer, null: false, default: 0, limit: 2
  end
end
