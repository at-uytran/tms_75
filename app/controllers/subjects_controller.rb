class SubjectsController < ApplicationController
  before_action :load_subject, only: %i(show)
  before_action :load_info_chart, only: %i(show)
  before_action :load_members, only: %i(show)

  def show
    @tasks = @subject.tasks
    @user_subject = current_user.user_subjects.find_by subject_id: @subject.id
    return if @user_subject
    flash[:danger] = t "error"
    redirect_to root_path
  end

  private

  def load_members
    @course_current = Course.find_by id: params[:course_id]
    @trainees = @course_current.users.trainee.alphabet
    @trainers = @course_current.users.trainer.alphabet
    @total = @trainees.size + @trainers.size
  end

  def load_subject
    @subject = Subject.find_by id: params[:id]
    return if @subject
    flash[:danger] = t "courses.load_subject.not_found"
    redirect_to root_path
  end

  def load_info_chart
    @course_current = Course.find_by id: params[:course_id]
    @subject_current = Subject.find_by id: params[:id]
    @user_courses = @course_current.user_courses.includes(:user)
    return if @subject_current && @user_courses
    flash[:danger] = t "error"
    redirect_to root_path
  end
end
