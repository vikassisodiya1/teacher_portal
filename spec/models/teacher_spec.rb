# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Teacher, type: :model do
  # Associations
  it { should belong_to(:user) }
  it { should have_many(:subjects).dependent(:destroy) }

  # Validations
  it { should validate_presence_of(:qualification) }
  it { should validate_presence_of(:experience) }

  # Ensure experience is an integer
  it { should validate_numericality_of(:experience).only_integer }

  # Ensure experience is greater than or equal to zero
  it { should validate_numericality_of(:experience).is_greater_than_or_equal_to(0) }
end
