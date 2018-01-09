class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  attr_accessor :remember_token
  validates :email, presence: true, length: {maximum: Settings.email_max_lengh},
    format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  validates :password, presence: true,
    length: {minimum: Settings.password_min_lengh}, allow_nil: true
  validates :name, presence: true, length: {maximum: Settings.name_max_lengh}
  validates :address, length: {maximum: Settings.address_max_lengh}
  validates :school, length: {maximum: Settings.school_max_lengh}
  validate  :picture_size
  has_many :user_courses, dependent: :nullify
  has_many :courses, through: :user_courses
  has_many :user_tasks, dependent: :nullify
  has_many :tasks, through: :user_tasks
  has_many :user_subjects, dependent: :nullify
  has_many :subjects, through: :user_subjects
  before_save :downcase_email
  has_secure_password
  enum roles: {trainee: 0, trainer: 1, admin: 2}

  mount_uploader :picture, PictureUploader

  scope :desc_created_at, ->{order(created_at: :desc)}
  scope :alphabet, ->{order(name: :desc)}

  # log in - log out
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated? attribute, token
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def forget
    update_attribute :remember_digest, nil
  end

  def picture_size
    return unless picture.size > Settings.picture_size.megabytes
    errors.add(:picture, I18n.t(".Max_size_picure"))
  end

  def add_subjects subjects
    subjects.transaction do
      subjects.each do |subject|
        raise ActiveRecord::Rollback if subject.nil?
        user_subjects.create!(subject_id: subject.id)
      end
    end
  end

  def add_task user_id, task_id, status
    user_tasks.create(user_id: user_id, task_id: task_id, status: status)
  end

  class << self
    def digest string
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  private

  def downcase_email
    self.email = email.downcase
  end
end
