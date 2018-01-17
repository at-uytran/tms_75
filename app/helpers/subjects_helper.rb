module SubjectsHelper
  def data_chart_subject(user,subject)
    data_chart = Hash.new
    user.each do |user|
      loaduser=User.find_by(id: user.user_id)
      sum=subject.user_tasks.where(status: "done", user_id: user.user_id).size
      data_chart[loaduser.name]=sum
    end
    return data_chart
  end

  def show_chart_subject (user,subject)
    column_chart data_chart_subject(user,subject),
      height: "300px",
      title: "Trainees progress",
      xtitle: "Name",
      ytitle:  "task complete"
  end
end
