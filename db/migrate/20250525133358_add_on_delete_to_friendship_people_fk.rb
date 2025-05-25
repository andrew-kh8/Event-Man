class AddOnDeleteToFriendshipPeopleFk < ActiveRecord::Migration[8.0]
  def change
    remove_foreign_key :friendships, :people, column: :author_id
    add_foreign_key :friendships, :people, column: :author_id, on_delete: :cascade, validate: false

    remove_foreign_key :friendships, :people, column: :follower_id
    add_foreign_key :friendships, :people, column: :follower_id, on_delete: :cascade, validate: false
  end
end
