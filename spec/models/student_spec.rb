# frozen_string_literal: true

# spec/models/student_spec.rb

require 'rails_helper'

RSpec.describe Student, type: :model do
  # Associations
  it { should have_many(:marks).dependent(:destroy) }
  it { should have_many(:subjects).through(:marks) }
  it { should accept_nested_attributes_for(:marks).allow_destroy(true) }

  # Validations
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
end
