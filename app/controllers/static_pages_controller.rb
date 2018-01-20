class StaticPagesController < ApplicationController
  def home
    if current_user.nil?
      redirect_to login_path
    else
      if current_user.admin? || current_user.trainer?
        redirect_to supervisor_courses_path
      else
        redirect_to courses_path
      end
    end
  end
end
