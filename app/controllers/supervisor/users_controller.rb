module Supervisor
  class UsersController < ApplicationController
    layout "supervisor_layout"
    before_action :logged_in_user
    before_action :admin_user
    before_action :find_user, except: %i(index new)

    def index
      @trainers = User.trainer.desc_created_at.page(params[:page]).per_page(Settings.courses.per_page)
      @trainees = User.trainee.desc_created_at.page(params[:page]).per_page(Settings.courses.per_page)
    end

    def show; end

    def new
      @user = User.new
    end

    def create
      @user = User.new user_params
      if @user.save
        flash[:info] = t "courses.create.success"
        redirect_to supervisor_users_path
      else
        render :new
      end
    end

    def edit; end

    def update
      if @user.update_attributes user_params
        flash[:success] = t "controllers.user_controller.update_success"
        redirect_to supervisor_users_path
      else
        render :edit
      end
    end

    def destroy
      flash[:success] =
        if @user.destroy
          t "courses.destroy.success"
        else
          t "courses.destroy.failed"
        end
      redirect_back fallback_location: supervisor_users_path
    end

    private

    def user_params
      params.require(:user).permit :name, :email, :password,
        :password_confirmation, :address, :school, :picture, :roles
    end
  end
end
