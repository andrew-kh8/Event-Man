# frozen_string_literal: true

class Notification < ApplicationRecord
  INFO = 'info'
  INVITE = 'invite'
  OFFER = 'offer'
  WARNING = 'warning'

  belongs_to :person
  belongs_to :author, polymorphic: true
  belongs_to :target, polymorphic: true

  enum :notice_type, [INFO, INVITE, OFFER, WARNING].index_with(&:itself)

  scope :unread, -> { where(read: false) }

  validates :text, :author_id, :author_type, :target_type, :notice_type, presence: true
  validates :read, inclusion: [true, false]
end
