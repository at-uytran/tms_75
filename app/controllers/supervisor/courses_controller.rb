module Supervisor
  class CoursesController < ApplicationController
    layout "supervisor_layout"
    before_action :load_course, except: %i(index new create)
    before_action :logged_in_user
    before_action :admin_user

    def index
      @courses = Course.created_desc.page(params[:page]).per_page(Settings.courses.per_page)
      return if params[:search].blank?
      @courses = Course.search(params[:search]).page(params[:page]).per_page(Settings.courses.per_page)
    end

    def show
      load_course_sb @course
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
        flash[:info] = t "courses.create.success"
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
        flash[:success] = t "courses.update.success"
      else
        flash[:danger] = t "courses.update.failed"
      end
      render :edit
    end

    def destroy
      if @course.destroy
        flash[:success] = t "courses.destroy.success"
        redirect_to supervisor_courses_path
      else
        flash[:success] = t "courses.destroy.failed"
        redirect_back fallback_location: root_path
      end
    end

    private

    def course_params
      params.require(:course).permit :name, :description, :status, :start_at, :end_at, :picture
    end

    def load_course_sb course
      @course_subjects = course.course_subjects.includes(:subject)
      return if @course_subjects
      flash[:danger] = t "controllers.courses.show.no_subject"
    end

    def load_course
      @course = Course.find_by id: params[:id]
      return if @course
      flash[:danger] = t "error"
      redirect_to supervisor_courses_path
    end

    def load_subjects course
      @subjects = course.subjects
      @all_subjects = Subject.all.page(params[:page]).per_page(Settings.courses.per_page)
    end

    def load_trainers course
      @trainers = course.users.trainer.alphabet.page(params[:page]).per_page(Settings.courses.per_page)
    end

    def load_trainees course
      @trainees = course.users.trainee.alphabet.page(params[:page]).per_page(Settings.courses.per_page)
    end

    def load_all_users
      @trainers = User.trainer.alphabet.page(params[:page]).per_page(Settings.courses.per_page)
      @trainees = User.trainee.alphabet.page(params[:page]).per_page(Settings.courses.per_page)
    end
  end
end
