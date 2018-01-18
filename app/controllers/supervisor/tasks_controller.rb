module Supervisor
  class TasksController < ApplicationController
    layout "supervisor_layout"
    before_action :load_task, only: %i(edit update destroy)
    before_action :load_create, only: %i(create)

    def new
      @task = Task.new
    end

    def create
      @task = Task.new task_params
      redirect_to new_supervisor_subject_path @subject
    end

    def edit; end

    def update
      if @task.update_attributes task_params
        flash[:success] = I18n.t "tasks.update.success"
        redirect_to root_path
      else
        flash[:danger] = I18n.t "tasks.update.failed"
        render :edit
      end
    end

    def destroy
      if @task.destroy
        flash[:success] = t "task.destroy.success"
      else
        flash[:success] = t "taks.destroy.failed"
      end
      redirect_to edit_supervisor_subject_path @subject
    end

    private

    def task_params
      params.require(:task).permit :name, :description, :subject_id
    end

    def load_task
      @task = Task.find_by id: params[:id]
      @subject = Subject.find_by id: @task.subject_id
      return if @task
      flash[:danger] = I18n.t "tasks.load_subject.not_found"
      redirect_to supervisor_courses_path
    end

    def load_create
      @subject_id = params[:subject_id]
      @subject = Subject.find_by id: @subject_id
      name = params[:name]
      description = params[:description]
    end

    def load_subject
      @subject_id = params[:subject_id]
      @subject = Subject.find_by id: @subject_id
    end
  end
end
