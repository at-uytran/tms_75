class SubjectsController < ApplicationController
  before_action :load_subject, except: %i(create new index)
  before_action :load_info_chart, only: %i(show)

  def index
    @subjects = Subject.created_desc.page(params[:page]).per_page(Settings.subjects.per_page)
    load_course if params[:course_id]
    return unless @course
    @subjects = @course.subjects.created_desc.page(params[:page])
      .per_page(Settings.subjects.per_page)
  end

  def show
    @tasks = @subject.tasks
  end

  def new
    @subject = Subject.new
  end

  def create
    @subject = Subject.new subject_params
    if @subject.save
      flash[:info] = I18n.t "subjects.create.success"
      redirect_to @subject
    else
      render :new
    end
  end

  def edit; end

  def update
    if @subject.update_attributes subject_params
      flash[:success] = I18n.t "subjects.update.success"
      redirect_to root_path
    else
      flash[:danger] = I18n.t "subjects.update.failed"
      render :edit
    end
  end

  def destroy
    if @subject.destroy
      flash[:success] = I18n.t "subjects.destroy.success"
      redirect_to subjects_path
    else
      flash[:success] = I18n.t "subjects.destroy.failed"
      redirect_to :back
    end
  end

  private

  def load_course
    @course = Course.find_by id: params[:course_id]
    return if @course
    flash[:danger] = I18n.t "wrong"
    redirect_to root_path
  end

  def subject_params
    params.require(:subject).permit :name, :description, :duration, :picture
  end

  def load_subject
    @subject = Subject.find_by id: params[:id]
    return if @subject
    flash[:danger] = I18n.t "courses.load_subject.not_found"
    redirect_to root_path
  end

  def load_info_chart
    @course_current = Course.find_by id: params[:course_id]
    @subject_current = Subject.find_by id: params[:id]
    @user = @course_current.user_courses.includes(:user)
  end
end
