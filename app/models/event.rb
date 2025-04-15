class Event < ApplicationRecord
  SRID = 4326

  mount_uploader :image, ImageUploader

  belongs_to :organization
  has_many :participants, dependent: :destroy_async
  has_many :people, through: :participants

  validates :name, :start_date, :end_date, presence: true
end
