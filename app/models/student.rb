# frozen_string_literal: true

class Student < ApplicationRecord
  has_many :marks, dependent: :destroy
  has_many :subjects, through: :marks

  accepts_nested_attributes_for :marks, allow_destroy: true
end
