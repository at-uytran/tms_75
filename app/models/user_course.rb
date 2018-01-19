class UserCourse < ApplicationRecord
  belongs_to :user
  belongs_to :course

  scope :search_course, ->(key){eager_load(:course).where("courses.name LIKE ?", "%#{key}%")}
  enum status: {joined: 0, in_progress: 1, finished: 2}
  delegate :description, :name, :status, to: :course, prefix: true
end
