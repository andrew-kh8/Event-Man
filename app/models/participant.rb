class Participant < ApplicationRecord
  belongs_to :person
  belongs_to :event

  validates :visible, inclusion: ['private', 'normal', 'public']
  enum :visible, { private: -1, normal: 0, public: 1 }, suffix: true

  scope :public_or_normal_visible, -> { where(visible: ['public', 'normal']) }
  scope :accepted, -> { where(accepted: true) }
end
