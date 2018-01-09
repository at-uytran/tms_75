class CourseSubject < ApplicationRecord
  belongs_to :course
  belongs_to :subject
  enum status: {init: 0, started: 1, stopped: 2}
end
