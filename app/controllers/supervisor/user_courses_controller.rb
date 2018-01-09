module Supervisor
  class UserCoursesController < ApplicationController
    before_action :check_params, only: %i(create)
    before_action :logged_in_user
    before_action :admin_user
    before_action :set_user_course, only: %i(destroy)

    def create
      if @course.assign_user @user
        @user_course = @user.user_courses.find_by(course_id: @course.id)
        respond_to do |format|
          format.html{redirect_to edit_supervisor_course_path(@course)}
          format.js
        end
      else
        flash[:danger] = t "supervisor.courses.button.add_trainer.failed"
        redirect_to :back
      end
    end

    def destroy
      @course = @user_course.course
      @user = @user_course.user
      @user_course_id = @user_course.id
      if @course.remove_user @user
        @user_course = @course.user_courses.build(user_id: @user.id)
        respond_to do |format|
          format.html{redirect_to edit_supervisor_course_path(@course)}
          format.js
        end
      else
        flash[:danger] = t "supervisor.courses.button.remove_user.failed"
        redirect_to :back
      end
    end

    private

    def set_user_course
      @user_course = UserCourse.find_by id: params[:id]
      return if @user_course
      flash[:danger] = t "error"
      redirect_to :back
    end

    def check_params
      @user = User.find_by id: params[:user_id]
      @course = Course.find_by id: params[:course_id]
      if @user && !@course
        flash[:danger] = t "supervisor.courses.add_user.course_not_found"
        redirect_to new_supervisor_course_path
      end
      return if @course || @user
      flash[:danger] = t "error"
      redirect_to supervisor_courses_path
    end

    def course_subjects_params
      params.require(:user_courses).permit :course_id, :user_id
    end
  end
end
