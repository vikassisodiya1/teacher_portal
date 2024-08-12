# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Subject, type: :model do
  # Associations
  it { should have_many(:marks).dependent(:destroy) }
  it { should have_many(:students).through(:marks) }
  it { should belong_to(:teacher) }

  # Validations
  it { should validate_presence_of(:name).with_message("Subject name can't be empty") }
end
