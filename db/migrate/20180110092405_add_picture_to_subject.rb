class AddPictureToSubject < ActiveRecord::Migration[5.1]
  def change
    add_column :subjects, :picture, :string
  end
end
