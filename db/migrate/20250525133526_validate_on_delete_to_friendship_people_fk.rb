class ValidateOnDeleteToFriendshipPeopleFk < ActiveRecord::Migration[8.0]
  def change
    validate_foreign_key :friendships, column: :author_id
    validate_foreign_key :friendships, column: :follower_id
  end
end
