class Participant < ApplicationRecord
  belongs_to :person
  belongs_to :event

  validates :visible, inclusion: %w[private normal public]
  enum :visible, { private: -1, normal: 0, public: 1 }, suffix: true
end
