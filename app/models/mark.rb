# frozen_string_literal: true

class Mark < ApplicationRecord
  belongs_to :student
  belongs_to :subject

  validates :score, presence: true,
                    numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100,
                                    message: 'must be between 0 and 100' }

  validates :subject_id,
            uniqueness: { scope: :student_id, message: 'can only have one set of marks per subject per student' }
end
