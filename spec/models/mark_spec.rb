# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mark, type: :model do
  # Associations
  it { should belong_to(:student) }
  it { should belong_to(:subject) }

  # Validations
  it { should validate_presence_of(:score) }
  it {
    should validate_numericality_of(:score).is_greater_than_or_equal_to(0)
                                           .is_less_than_or_equal_to(100).with_message('must be between 0 and 100')
  }

  describe 'validations' do
    before do
      @student = create(:student)
      @subject = create(:subject, teacher: create(:teacher))
    end

    it 'validates uniqueness of subject_id scoped to student_id' do
      create(:mark, student: @student, subject: @subject)
      should validate_uniqueness_of(:subject_id).scoped_to(:student_id)
                                                .with_message('can only have one set of marks per subject per student')
    end
  end
end
