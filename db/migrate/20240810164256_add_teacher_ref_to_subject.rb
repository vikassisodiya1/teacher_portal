class AddTeacherRefToSubject < ActiveRecord::Migration[7.1]
  def change
    add_reference :subjects, :teacher, null: false, foreign_key: true
  end
end
