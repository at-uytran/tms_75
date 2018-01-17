class SubjectsController < ApplicationController
  before_action :load_subject, only: %i(show)

  def show
    @tasks = @subject.tasks
    @user_subject = current_user.user_subjects.find_by subject_id: @subject.id
    return if @user_subject
    flash[:danger] = t "error"
    redirect_to root_path
  end

  private

  def load_course
    @course = Course.find_by id: params[:course_id]
    return if @course
    flash[:danger] = t "wrong"
    redirect_to root_path
  end

  def subject_params
    params.require(:subject).permit :name, :description, :duration, :picture
  end

  def load_subject
    @subject = Subject.find_by id: params[:id]
    return if @subject
    flash[:danger] = t "courses.load_subject.not_found"
    redirect_to root_path
  end
end
