# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  # Ensure Devise modules are included
  it { should have_db_column(:email).of_type(:string) }
  it { should have_db_column(:encrypted_password).of_type(:string) }
  it { should have_db_column(:reset_password_token).of_type(:string) }
  it { should have_db_column(:reset_password_sent_at).of_type(:datetime) }
  it { should have_db_column(:remember_created_at).of_type(:datetime) }

  # Associations
  it { should have_one(:teacher).dependent(:destroy) }
  it { should accept_nested_attributes_for(:teacher) }

  # Callbacks
  describe 'callbacks' do
    it 'sets the default role to teacher before saving' do
      user = User.create(email: 'test@example.com', password: 'password123', password_confirmation: 'password123')
      expect(user.role).to eq('teacher')
    end
  end

  # Devise Validations
  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
    it { should validate_confirmation_of(:password) }
    it { should validate_length_of(:password).is_at_least(6) }
  end
end
