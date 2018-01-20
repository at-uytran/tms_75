class CreateSubjects < ActiveRecord::Migration[5.1]
  def change
    create_table :subjects do |t|
      t.string :name
      t.text :description
      t.integer :duration
      t.text :resources

      t.timestamps
    end
  end
end
