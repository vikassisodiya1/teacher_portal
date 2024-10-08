# frozen_string_literal: true

class Student < ApplicationRecord
  has_many :marks, dependent: :destroy
  has_many :subjects, through: :marks

  accepts_nested_attributes_for :marks, allow_destroy: true

  validates :first_name, presence: true
  validates :last_name, presence: true
end
