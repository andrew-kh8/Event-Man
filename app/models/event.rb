class Event < ApplicationRecord
  SRID = 4326

  belongs_to :organization

  mount_uploader :image, ImageUploader

  validates :name, :start_date, :end_date, presence: true
end
