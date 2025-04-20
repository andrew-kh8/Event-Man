class Person < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  mount_uploader :avatar, AvatarUploader

  has_many :followers, class_name: 'Friendship', foreign_key: 'author_id', inverse_of: :author, dependent: :destroy
  has_many :followers_people, through: :followers, source: :author
  has_many :following, class_name: 'Friendship', foreign_key: 'follower_id', inverse_of: :follower, dependent: :destroy
  has_many :following_people, through: :following, source: :follower
  has_many :participants, dependent: :destroy_async
  has_many :events, through: :participants

  has_many :notifications, dependent: :destroy_async

  has_many :authored_notifications, as: :author, dependent: :nullify, class_name: 'Notification'
  has_many :notice_targets, as: :target, dependent: :nullify, class_name: 'Notification'

  has_many :starred_organizations, dependent: :destroy

  validates :first_name, presence: true

  def full_name
    [first_name, last_name].compact.join(' ')
  end

  def request_friends_for_person
    Person.where(id: followers.or(following).where(not_approved: self).pluck(:author_id, :follower_id)).where.not(id:)
  end

  def request_friends_from_person
    Person.where(id: followers.or(following).where.not(not_approved: [nil, id]).pluck(:author_id,
                                                                                      :follower_id)).where.not(id:)
  end

  def friends
    Person.where(id: followers.or(following).where(not_approved: nil).pluck(:author_id, :follower_id)).where.not(id:)
  end

  def friend?(person)
    friends.exists?(id: person.id)
  end

  def accepted_events
    events.joins(:participants).where(participants: { accepted: true })
  end

  def starred?(organization_id)
    starred_organizations.select(:organization_id).exists?(organization_id:)
  end
end
