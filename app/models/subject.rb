class Subject < ApplicationRecord
  has_many :course_subjects, dependent: :nullify
  has_many :course, through: :course_subjects
  has_many :tasks, dependent: :nullify
  has_many :user_tasks, through: :tasks
  validates :name, presence: true, length: {minimum: Settings.subjects.name_min_len},
    uniqueness: {case_sensitive: false}, allow_nil: true
  validates :description, presence: true,
    length: {minimum: Settings.subjects.des_min_len}
  validate  :picture_size

  scope :created_desc, ->{order(created_at: :desc)}
  mount_uploader :picture, PictureUploader

  def picture_size
    return unless picture.size > Settings.picture_size.megabytes
    errors.add(:picture, I18n.t(".Max_size_picure"))
  end

  def add_task name, description, subject_id
    tasks.create(name: name, description: description, subject_id: subject_id)
  end
end
