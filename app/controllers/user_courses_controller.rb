class UserCoursesController < ApplicationController
  before_action :load_user_course
  before_action :logged_in_user

  def update
    if @user_course.joined?
      if current_user.course_active_size.zero?
        update_status
      else
        flash[:danger] = t "controllers.user_courses.update.check_active"
        redirect_back fallback_location: @user_course.course
      end
    else
      update_status
      redirect_back fallback_location: @user_course.course
    end
  end

  private

  def update_status
    @user_course.update user_course_params
    respond_to do |format|
      format.html{redirect_back fallback_location: @user_course.course}
      format.js
    end
  end

  def load_user_course
    @user_course = UserCourse.find_by id: params[:id]
    return if @user_course
    flash[:danger] = t "error"
    redirect_back fallback_location: @user_course.course
  end

  def user_course_params
    params.require(:user_course).permit :user_id, :course_id, :status
  end
end
