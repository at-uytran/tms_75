class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  include Supervisor::CoursesHelper

  private

  def admin_user
    redirect_to(root_url) unless current_user.admin? || current_user.trainer?
  end

  def logged_in_user
    unless logged_in?
      flash[:danger] = I18n.t "controllers.user_controller.pl_login"
      redirect_to login_url
    end
  end

  def correct_user
    find_user
    redirect_to(root_url) unless current_user?(@user)
  end

  def correct_user?
    find_user
    current_user? @user
  end

  def find_user
    @user = User.find_by(id: params[:id])
    return if @user
    flash[:success] = I18n.t "controllers.user_controller.fail"
  end
end
