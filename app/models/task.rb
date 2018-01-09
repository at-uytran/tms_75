class Task < ApplicationRecord
  has_many :user_tasks, dependent: :destroy
  has_many :users, through: :user_tasks
  belongs_to :subject
  enum status: {in_progres: 0, finished: 1}

  scope :get_task, ->(id){where(subject_id: id)}
end
