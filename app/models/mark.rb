class Mark < ApplicationRecord
  belongs_to :student
  belongs_to :subject

  validates :subject_id, uniqueness: { scope: :student_id, message: "can only have one set of marks per subject per student" }

end
