# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# User.create!(name: "Tran Van Uy",
#              email: "vanuy113@gmail.com",
#              password: "123456",
#              roles: 2)

# 50.times do |n|
#   Course.create!(name: "Example Course #{n+1}",
#                  description: "lorem ipsum #{n+1}",
#                  status: 1,
#                  start_at: Time.zone.now,
#                  end_at: Time.zone.now)

#   Subject.create!(name: "Example Subject #{n+1}",
#                   description: "subject lorem ipsum #{n+1}",
#                   duration: n)

#   User.create!(name: "Example User #{n+1}",
#                email: "example#{n+1}@gmail.com",
#                password: "123456")
# end

# 20.times do |n|
#   CourseSubject.create!(course_id: 1,
#                         subject_id: n+1,
#                         deadline: Time.zone.now)

#   UserCourse.create!(course_id: n+1,
#                      user_id: 1,
#                      status: 0)
# end

# 10.times do |n|
#   User.create!(name: "trainer #{n+1}",
#                 email: "trainer#{n+1}@gmail.com",
#                 password: "123456",
#                 roles: 1)
#   UserCourse.create!(course_id: 1,
#                      user_id: User.trainee.ids.sample)
#   UserCourse.create!(course_id: 1,
#                      user_id: User.trainer.ids.sample)
# end

# 10.times do |n|
#   UserSubject.create!(status: 1,
#                       user_id: 1, subject_id: n+1,
#                       created_at: Time.zone.now,
#                       updated_at: Time.zone.now)
# end

# 30.times do |n|
#   Task.create!(name: "Example Task #{n+1}",
#                description: "taks lorem ipsum #{n+1}",
#                subject_id: 1)
# end

# 30.times do |n|
#   UserTask.create!(user_id: 1,
#                    task_id: n+1,
#                    status: 1,
#                    created_at: Time.zone.now,
#                    updated_at: Time.zone.now)
# end


# 10.times do |n|
#   Course.create(name: Faker::Educator.course,
#                 description: Faker::Lorem.sentence,
#                 start_at: Time.zone.now,
#                 end_at: Time.zone.now)
# end

User.create(name: "Tran Van Uy",
            email: "vanuy113@gmail.com",
            password: "123456",
            roles: 2)

User.create(name: "Le Van Hau",
            email: "vanhau195@gmail.com",
            password: "123456",
            roles: 2)

5.times do |n|
  User.create!(name: Faker::Name.name,
               email: "trainer_#{n+1}@gmail.com",
               password: "123456",
               roles: 1)
end

20.times do |n|
  User.create!(name: Faker::Name.name,
               email: "trainee_#{n+1}@gmail.com",
               password: "123456")
end

Course.create!(name: "[DN-OE-08]Open education batch 8",
              description: "Ruby open education training",
              status: 0,
              start_at: Time.zone.now,
              end_at: Time.zone.now)

Course.create!(name: "[DN-OE-08-PHP]PHP - Open education batch 8",
              description: "PHP open education training",
              status: 0,
              start_at: Time.zone.now,
              end_at: Time.zone.now)

Course.create!(name: "[DN-OE-08-ANDROID]ANDROID - Open education batch 8",
              description: "ANDROID open education training",
              status: 0,
              start_at: Time.zone.now,
              end_at: Time.zone.now)

Subject.create!(name: "Github training",
                description: "Start Git for your project today.",
                resources: "",
                duration: 2)


Subject.create!(name: "Ruby on Rails Tutorial Book",
                description: "Learn the basic building blocks of Ruby, all in the browser.",
                resources: "",
                duration: 10)

Subject.create!(name: "Ruby's Project 1",
                description: "Start Project 1 for Ruby on Rails today.",
                resources: "",
                duration: 10)

Subject.create!(name: "PHP's Project 1",
                description: "Start Project 1 for Laravel today.",
                resources: "",
                duration: 10)

Subject.create!(name: "PHP's Tutorial Book",
                description: "Learn the basic building blocks of PHP, all in the browser.",
                resources: "",
                duration: 10)

Subject.create!(name: "ANDROID's Tutorial Book",
                description: "Learn the basic building blocks of ANDROID, all in the device.",
                resources: "",
                duration: 10)

5.times do |n|
  Subject.create!(name: Faker::Book.title,
                  description: Faker::Lorem.sentence,
                  resources: "",
                  duration: 10)
end

5.times do |n|
  Task.create!(name: "Getting Started #{n + 1}",
                description: "Get an introduction to project git",
                subject_id: 1)

  Task.create!(name: "Getting Started #{n + 1}",
                description: "Get an introduction to project git",
                subject_id: 2)

  Task.create!(name: "Getting Started #{n + 1}",
                description: "Get an introduction to project git",
                subject_id: 3)

  Task.create!(name: "Getting Started #{n + 1}",
                description: "Get an introduction to project git",
                subject_id: 4)

  Task.create!(name: "Getting Started #{n + 1}",
                  description: "Get an introduction to project git",
                  subject_id: 5)

  Task.create!(name: "Getting Started #{n + 1}",
                  description: "Get an introduction to project git",
                  subject_id: 6)
end

3.times do |n|
  CourseSubject.create!(course_id: 1,
                        subject_id: n + 1,
                        deadline: 25.days.since(Date.today))
end

3.times do |n|
  CourseSubject.create!(course_id: 2,
                        subject_id: n + 2,
                        deadline: 25.days.since(Date.today))
end

3.times do |n|
  CourseSubject.create!(course_id: 3,
                        subject_id: n + 2,
                        deadline: 25.days.since(Date.today))
end
