class UserSubjectsController < ApplicationController
  before_action :load_user_subject
  before_action :logged_in_user

  def update
    if @user_subject.update user_subject_params
      respond_to do |format|
        format.html{redirect_to :back}
        format.js
      end
    else
      flash[:danger] = t "controllers.user_courses.update.failed"
      redirect_to :back
    end
  end

  private

  def load_user_subject
    @user_subject = UserSubject.find_by id: params[:id]
    return if @user_subject
    flash[:danger] = t "error"
    redirect_to :back
  end

  def user_subject_params
    params.require(:user_subject).permit :user_id, :subject_id, :status
  end
end
