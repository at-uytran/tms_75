module Supervisor
  class SubjectsController < ApplicationController
    layout "supervisor_layout"
    before_action :load_subject, except: %i(index new create)

    def index
      @subjects = Subject.created_desc.page(params[:page]).per_page(Settings.courses.per_page)
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
        redirect_to edit_supervisor_subject_path @subject
      else
        render :new
      end
    end

    def edit
      @new_task = Task.new
      @tasks = @subject.tasks
    end

    def update
      if @subject.update_attributes subject_params
        flash[:success] = I18n.t "subjects.update.success"
        redirect_to supervisor_subjects_path
      else
        flash[:danger] = I18n.t "subjects.update.failed"
        render :edit
      end
    end

    def destroy
      flash[:success] =
        if @subject.destroy
          t "courses.destroy.success"
        else
          t "courses.destroy.failed"
        end
      redirect_back fallback_location: supervisor_subjects_path
    end

    private

    def load_subject
      @subject = Subject.find_by id: params[:id]
      return if @subject
      flash[:danger] = I18n.t "courses.load_subject.not_found"
      redirect_to supervisor_subjects_path
    end

    def subject_params
      params.require(:subject).permit :name, :description, :duration, :picture
    end
  end
end
