# frozen_string_literal: true

class Teacher < ApplicationRecord
  belongs_to :user
  has_many :subjects, dependent: :destroy

  validates :qualification, presence: true
  validates :experience, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
