class Organization < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  mount_uploader :logo, LogoUploader

  has_many :events, dependent: :destroy_async
  has_many :authored_notifications, as: :author, dependent: :nullify, class_name: 'Notification'

  validates :email, :name, presence: true
end
