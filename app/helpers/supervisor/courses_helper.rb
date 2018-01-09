module Supervisor
  module CoursesHelper
    def load_subject_form course, subject
      course.course_subjects.find_by(subject_id: subject.id)
    end

    def load_user_form course, user
      @user_course = course.user_courses.find_by(user_id: user.id)
    end

    def start course
      users = course.users
      subjects = course.subjects
      if course.start(users, subjects)
        flash[:success] = t "supervisor.courses.update_status.success"
        redirect_to edit_supervisor_course_path(course)
      else
        flash[:success] = t "supervisor.courses.update_status.failed"
        render :edit
      end
    end
  end
end
