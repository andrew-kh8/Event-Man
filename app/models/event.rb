class Event < ApplicationRecord
  SRID = 4326

  mount_uploader :image, ImageUploader

  belongs_to :organization
  has_many :participants, dependent: :destroy_async
  has_many :people, through: :participants

  has_many :notice_targets, as: :target, dependent: :nullify, class_name: 'Notification'

  validates :name, :start_date, :end_date, presence: true
end
