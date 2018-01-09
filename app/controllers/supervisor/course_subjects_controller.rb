module Supervisor
  class CourseSubjectsController < ApplicationController
    before_action :check_params, except: %i(update)
    before_action :logged_in_user
    before_action :admin_user
    before_action :set_course_subject, only: %i(update)

    def create
      start_at = Date.parse(params[:course_subject][:start_at], "%m/%d/%Y")
      @course.add_sb @subject, start_at
      redirect_to edit_supervisor_course_path(@course)
    end

    def destroy
      @course.remove_sb @subject
      redirect_to edit_supervisor_course_path(@course)
    end

    def update
      if @cou_subject.update_attributes course_subjects_params
        flash[:success] = t "supervisor.courses.update_status.success"
        respond_to do |format|
          format.html{redirect_to supervisor_course_path(@cou_subject.course)}
          format.js
        end
      else
        flash[:danger] = t "supervisor.courses.update_status.failed_update"
        redirect_to supervisor_course_path(@cou_subject.course)
      end
    end

    private

    def set_course_subject
      @cou_subject = CourseSubject.find_by id: params[:id]
      return if @cou_subject
      flash[:danger] = t "error"
      redirect_to :back
    end

    def check_params
      @subject = Subject.find_by id: params[:subject_id]
      @course = Course.find_by id: params[:course_id]
      return if @course || @subject
      flash[:danger] = t "error"
      redirect_to supervisor_courses_path
    end

    def course_subjects_params
      params.require(:course_subject).permit :course_id, :subject_id, :start_at, :status
    end
  end
end
