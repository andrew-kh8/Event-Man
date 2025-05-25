class Event < ApplicationRecord
  acts_as_taggable_on :tags

  SRID = 4326

  mount_uploader :image, ImageUploader

  belongs_to :organization
  has_many :participants, dependent: :delete_all
  has_many :people, through: :participants

  has_many :notice_targets, as: :target, dependent: :nullify, class_name: 'Notification'

  validates :name, :start_date, :end_date, presence: true
  validates :online, inclusion: [true, false]
end
