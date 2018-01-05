class Subject < ApplicationRecord
  has_many :course_subjects, dependent: :nullify
  has_many :users, through: :course_subjects
  has_many :tasks, dependent: :nullify
  validates :name, presence: true, length: {minimum: Settings.subjects.name_min_len},
                   uniqueness: {case_sensitive: false},
                   allow_nil: true
  validates :description, presence: true,
                          length: {minimum: Settings.subjects.des_min_len}
  scope :created_desc, ->{order(created_at: :desc)}
end
