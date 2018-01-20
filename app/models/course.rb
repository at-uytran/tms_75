class Course < ApplicationRecord
  has_many :user_courses, dependent: :nullify
  has_many :course_subjects, dependent: :nullify
  has_many :users, through: :user_courses
  has_many :subjects, through: :course_subjects
  has_many :having_sb, through: :course_subjects, source: :subject
  has_many :having_user, through: :user_courses, source: :user
  validates :name, presence: true
  validates :description, presence: true
  validate  :picture_size
  validates_presence_of :start_at, :end_at
  validate :end_date_is_after_start_date
  mount_uploader :picture, PictureUploader

  scope :search, ->(key){where("name LIKE ?", "%#{key}%")}
  scope :total_size, ->{all.size}
  scope :total_init_size, ->{init.size}
  scope :total_in_progress_size, ->{in_progress.size}
  scope :total_finished_size, ->{finished.size}
  scope :created_desc, ->{order(created_at: :desc)}
  enum status: {init: 0, in_progress: 1, finished: 2}

  def end_date_is_after_start_date
    return if end_at.blank? || start_at.blank?
    if end_at < start_at
      errors.add(:end_at, I18n.t("date_validate"))
    end
  end

  def picture_size
    return unless picture.size > Settings.picture_size.megabytes
    errors.add(:picture, I18n.t(".Max_size_picure"))
  end

  def add_sb subject, start_at
    deadline = start_at + subject.duration.days
    course_subjects.create(subject_id: subject.id, deadline: deadline)
  end

  def remove_sb subject
    having_sb.delete subject
  end

  def assign_user user
    user_courses.create(user_id: user.id)
  end

  def remove_user user
    having_user.delete user
  end

  def start users, subjects
    users.transaction do
      users.each do |user|
        raise ActiveRecord::Rollback if user.nil?
        user.add_subjects subjects
      end
    end
  end

  def start_sb subject
    course_subjects.with_subject(subject).started!
  end

  def stop_sb subject
    course_subjects.with_subject(subject).stopped!
  end
end
