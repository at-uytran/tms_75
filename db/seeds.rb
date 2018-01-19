# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(name: "Tran Van Uy",
             email: "vanuy113@gmail.com",
             password: "123456",
             roles: 2)

50.times do |n|
  Course.create!(name: "Example Course #{n+1}",
                 description: "lorem ipsum #{n+1}",
                 status: 1,
                 start_at: Time.zone.now,
                 end_at: Time.zone.now)

  Subject.create!(name: "Example Subject #{n+1}",
                  description: "subject lorem ipsum #{n+1}",
                  duration: n)

  User.create!(name: "Example User #{n+1}",
               email: "example#{n+1}@gmail.com",
               password: "123456")
end

20.times do |n|
  CourseSubject.create!(course_id: 1,
                        subject_id: n+1,
                        deadline: Time.zone.now)

  UserCourse.create!(course_id: n+1,
                     user_id: 1,
                     status: 0)
end

10.times do |n|
  User.create!(name: "trainer #{n+1}",
                email: "trainer#{n+1}@gmail.com",
                password: "123456",
                roles: 1)
  UserCourse.create!(course_id: 1,
                     user_id: User.trainee.ids.sample)
  UserCourse.create!(course_id: 1,
                     user_id: User.trainer.ids.sample)
end

10.times do |n|
  UserSubject.create!(status: 1,
                      user_id: 1, subject_id: n+1,
                      created_at: Time.zone.now,
                      updated_at: Time.zone.now)
end

30.times do |n|
  Task.create!(name: "Example Task #{n+1}",
               description: "taks lorem ipsum #{n+1}",
               subject_id: 1)
end

30.times do |n|
  UserTask.create!(user_id: 1,
                   task_id: n+1,
                   status: 1,
                   created_at: Time.zone.now,
                   updated_at: Time.zone.now)
end
