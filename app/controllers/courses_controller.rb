class CoursesController < ApplicationController
  before_action :load_course, only: %i(show)
  before_action :load_subjects, only: %i(show)
  before_action :load_members, only: %i(show)
  before_action :logged_in_user

  def index
    @user_courses = current_user.user_courses.includes(:course)
      .page(params[:page]).per_page(Settings.courses.per_page)
    return if params[:search].blank?
    @user_courses = current_user.user_courses.search_course(params[:search])
      .includes(:course).page(params[:page]).per_page(Settings.courses.per_page)
  end

  def show
    @course_subjects = @course.course_subjects.includes(:subject)
    @user_course = current_user.user_courses.find_by course_id: @course.id
    return if @user_course
    flash[:danger] = t "controllers.courses.show.has_no_course"
  end

  private

  def course_params
    params.require(:course).permit :name, :description, :status,
      :start_at, :end_at, :picture
  end

  def load_course
    @course = Course.find_by id: params[:id]
    return if @course
    flash[:danger] = t "courses.load_course.not_found"
    redirect_to root_path
  end

  def load_subjects
    @subjects = current_user.subjects
  end

  def load_members
    @trainers = @course.users.trainer.alphabet
    @trainees = @course.users.trainee.alphabet
  end
end
