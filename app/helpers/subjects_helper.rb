module SubjectsHelper
  def get_status object
    if object.blank?
      fa_icon("circle task_init")
    else
      fa_icon("circle task_#{object.status}")
    end
  end

  def data_chart_subject users, subject
    data_chart = {}
    users.each do |user|
      return unless check_roles user
      name = get_name_user
      sum = subject.user_tasks.get_tasks_user(Settings.status_done, user.user_id).size
      data_chart[name] = sum
    end
    data_chart
  end

  def show_chart_subject users, subject
    column_chart data_chart_subject(users, subject),
      height: "300px",
      title: "Trainees progress",
      xtitle: "Name",
      ytitle:  "task complete"
  end

  def check_roles user
    get_user user
    return true if @user.trainee?
  end

  def get_name_user
    return @user.name if @user
    Settings.name_default
  end

  def get_user user
    @user = User.find_by(id: user.user_id)
  end

end
