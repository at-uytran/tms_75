class SubjectsController < ApplicationController
  before_action :load_subject, except: %i(create new index)

  def index
    num_of_record = Settings.subjects.per_page
    @subjects = if params[:course_id].present?
                  Course.find_by(id: params[:course_id])
                    .subjects.created_desc.page(params[:page]).per_page(num_of_record)
                else
                  Subject.created_desc.page(params[:page]).per_page(num_of_record)
                end
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

  def subject_params
    params.require(:subject).permit :name, :description, :duration
  end

  def load_subject
    @subject = Subject.find_by id: params[:id]
    return if @subject
    flash[:danger] = I18n.t "courses.load_subject.not_found"
    redirect_to root_path
  end
end
