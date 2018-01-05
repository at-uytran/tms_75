# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

50.times do |n|
  Course.create!(name: "Example Course #{n+1}",
                 description: "lorem ipsum #{n+1}",
                 status: 1,
                 start_at: Time.zone.now,
                 end_at: Time.zone.now)

  Subject.create!(name: "Example Subject #{n+1}",
                  description: "subject lorem ipsum #{n+1}",
                  duration: n)
end

20.times do |n|
  CourseSubject.create!(course_id: Course.all.limit(20).ids.sample,
                        subject_id: Subject.all.ids.sample,
                        deadline: Time.zone.now)
end
