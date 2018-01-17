class UserSubject < ApplicationRecord
  belongs_to :user
  belongs_to :subject
  enum status: {init: 0, finished: 1}
  delegate :name, :description, :duration, to: :subject, prefix: true
end
