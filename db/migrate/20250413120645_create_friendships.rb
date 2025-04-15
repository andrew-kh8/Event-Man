class CreateFriendships < ActiveRecord::Migration[8.0]
  def change
    create_table :friendships do |t|
      t.belongs_to :author, null: false, foreign_key: {to_table: :people}
      t.belongs_to :follower, null: false, foreign_key: {to_table: :people}
      t.belongs_to :not_approved, foreign_key: {to_table: :people}

      t.timestamps
    end
  end
end
