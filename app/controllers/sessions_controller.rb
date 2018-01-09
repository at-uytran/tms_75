class SessionsController < ApplicationController
  def new; end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      action_success
    else
      action_fail
    end
  end

  def action_success
    log_in @user
    params[:session][:remember_me] == Settings.check_remember ? remember(@user) : forget(@user)
    flash[:success] = I18n.t "controllers.sessions_controller.success"
    redirect_to supervisor_courses_path and return if current_user.admin? || current_user.trainer?
    redirect_to @user
  end

  def action_fail
    flash.now[:danger] = I18n.t "controllers.sessions_controller.fail"
    render :new
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
