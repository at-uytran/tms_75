class CreateCourseSubjects < ActiveRecord::Migration[5.1]
  def change
    create_table :course_subjects do |t|
      t.date :deadline
      t.integer :status, default: 0
      t.references :course, foreign_key: true
      t.references :subject, foreign_key: true

      t.timestamps
    end
  end
end
