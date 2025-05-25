class Notification < ApplicationRecord
  belongs_to :person
  belongs_to :author, polymorphic: true
  belongs_to :target, polymorphic: true

  scope :unread, -> { where(read: false) }

  validates :text, :author_id, :author_type, :target_type, :notice_type, presence: true
  validates :read, inclusion: [true, false]
end
