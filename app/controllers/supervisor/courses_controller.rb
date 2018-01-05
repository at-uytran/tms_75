class Supervisor::CoursesController < ApplicationController
  layout "supervisor_layout"

  def index
    @courses = Course.created_desc.page(params[:page]).per_page(Settings.courses.per_page)
  end

  def show; end

  def new; end

  def create; end

  def destroy; end

  private

  def load_course
    @course = Course.find_by id: params[:id]
    return if @course
    flash[:danger] = "Could not found"
    redirect_to supervisor_courses_path
  end
end
