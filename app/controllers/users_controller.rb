class UsersController < ApplicationController
  before_action :logged_in_user, only: %i(edit update)
  before_action :correct_user, only: %i(edit update)
  before_action :find_user, only: %i(show)
  add_breadcrumb I18n.t("bread_crumb.home"), :root_path

  def show
    add_breadcrumb I18n.t "bread_crumb.users", current_user
    @courses = current_user.courses.created_desc
    @check = correct_user?
  end

  def edit; end

  def update
    if @user.update_attributes user_params
      flash[:success] = I18n.t "controllers.user_controller.update_success"
      redirect_to @user
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation, :address, :school, :picture
  end
end
