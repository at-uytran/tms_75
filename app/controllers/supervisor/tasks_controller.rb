module Supervisor
  class TasksController < ApplicationController
    layout "supervisor_layout"
    before_action :load_task, only: %i(edit update destroy)
    before_action :load_current_subject, only: %i(create)

    def create
      @task = Task.new task_params
      @task.save
      redirect_to edit_supervisor_subject_path @subject
    end

    def edit; end

    def update
      if @task.update_attributes task_params
        flash[:success] = t "tasks.update.success"
        redirect_to edit_supervisor_subject_path @subject
      else
        flash[:danger] = t "tasks.update.failed"
        render :edit
      end
    end

    def destroy
      flash[:success] =
        if @task.destroy
          t "task.destroy.success"
        else
          t "taks.destroy.failed"
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
      flash[:danger] = t "tasks.load_subject.not_found"
      redirect_to supervisor_courses_path
    end

    def load_current_subject
      @subject_id = params[:subject_id]
      @subject = Subject.find_by id: @subject_id
      return if @subject
      flash[:danger] = t "tasks.load_subject.not_found"
      redirect_to supervisor_courses_path
    end
  end
end
