module Supervisor
  class CoursesController < ApplicationController
    layout "supervisor_layout"
    before_action :load_course, except: %i(index new create)
    before_action :logged_in_user
    before_action :admin_user

    def index
      @courses = Course.created_desc.page(params[:page]).per_page(Settings.courses.per_page)
    end

    def show
      load_cs @course
      load_subjects @course
      load_trainers @course
      load_trainees @course
    end

    def new
      @course = Course.new
    end

    def create
      @course = Course.new course_params
      if @course.save
        flash[:info] = I18n.t "courses.create.success"
        redirect_to supervisor_courses_path
      else
        render :new
      end
    end

    def edit
      load_subjects @course
      load_all_users
    end

    def update
      if @course.update_attributes course_params
        start @course if @course.in_progress?
        flash[:success] = I18n.t "courses.update.success"
      else
        flash[:danger] = I18n.t "courses.update.failed"
      end
    end

    def destroy
      if @course.destroy
        flash[:success] = I18n.t "courses.destroy.success"
        redirect_to supervisor_courses_path
      else
        flash[:success] = I18n.t "courses.destroy.failed"
        redirect_to :back
      end
    end

    private

    def update_status status
      case status
      when "in_progress"
        start @course
      when "finish"
        stop @course
      else
        flash[:danger] = t "error"
      end
    end

    def course_params
      params.require(:course).permit :name, :description, :status, :start_at, :end_at, :picture
    end

    def load_cs course
      @course_subjects = course.course_subjects.includes(:subject)
    end

    def load_course
      @course = Course.find_by id: params[:id]
      return if @course
      flash[:danger] = I18n.t "error"
      redirect_to supervisor_courses_path
    end

    def load_subjects course
      @subjects = course.subjects
      @all_subjects = Subject.all
    end

    def load_trainers course
      @trainers = course.users.trainer.alphabet
    end

    def load_trainees course
      @trainees = course.users.trainee.alphabet
    end

    def load_all_users
      @trainers = User.trainer.alphabet
      @trainees = User.trainee.alphabet
    end
  end
end
