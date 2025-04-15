class Friendship < ApplicationRecord
  belongs_to :author, class_name: 'Person', inverse_of: :followers
  belongs_to :follower, class_name: 'Person', inverse_of: :following
  belongs_to :not_approved, optional: true, class_name: 'Person'
end
