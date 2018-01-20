class UserSubject < ApplicationRecord
  belongs_to :user
  belongs_to :subject

  scope :search_subject, ->(key){eager_load(:subject).where("subjects.name LIKE ?", "%#{key}%")}
  enum status: {init: 0, finished: 1}
  delegate :name, :description, :duration, to: :subject, prefix: true
end
