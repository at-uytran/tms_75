class UserTasksController < ApplicationController
  before_action :check_params
  def new; end

  def create
    @user_task = current_user.add_task(params[:user_id], params[:task_id], params[:status])
    back_page
  end

  def update
    @user_task = UserTask.find_by(id: params[:id])
    if @user_task.update_attribute(:status, params[:status])
    else
      flash[:danger] = I18n.t "courses.update.failed"
    end
    back_page
  end

  def back_page
    respond_to do |format|
      format.html{course_subject_path(@subject, @course)}
      format.js
    end
  end

  private

  def user_tasks_params
    params.require(:user_task).permit :status, :user_id, :task_id
  end

  def check_params
    @course = Course.find_by id: params[:course_id]
    @data = Course.find_by id: params[:course_id]
    @subject = Subject.find_by id: params[:subject_id]
    @task_id = params[:task_id]
  end
end
