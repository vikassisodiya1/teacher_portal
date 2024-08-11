class CreateTeachers < ActiveRecord::Migration[7.1]
  def change
    create_table :teachers do |t|
      t.string :qualification
      t.integer :experience
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
