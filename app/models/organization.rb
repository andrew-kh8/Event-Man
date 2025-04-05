class Organization < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  mount_uploader :logo, LogoUploader

  has_many :events, dependent: :destroy_async

  validates :email, :name, presence: true
end
