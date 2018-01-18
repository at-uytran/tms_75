class UserTask < ApplicationRecord
  belongs_to :user
  belongs_to :task
  enum status: {doing: 0, done: 1}

  scope :get_tasks_user, ->(stt, user_id){where(status: stt, user_id: user_id)}
end
