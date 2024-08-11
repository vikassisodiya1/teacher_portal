class CreateMarks < ActiveRecord::Migration[7.1]
  def change
    create_table :marks do |t|
      t.integer :score
      t.references :student, null: false, foreign_key: true
      t.references :subject, null: false, foreign_key: true


      t.timestamps
    end
    
    # Ensure that each student can only have one mark per subject
    add_index :marks, [:student_id, :subject_id], unique: true

  end
end
