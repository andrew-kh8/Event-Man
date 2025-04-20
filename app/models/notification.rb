class Notification < ApplicationRecord
  belongs_to :person
  belongs_to :author, polymorphic: true
  belongs_to :target, polymorphic: true
end
