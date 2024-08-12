# frozen_string_literal: true

class Subject < ApplicationRecord
  has_many :marks, dependent: :destroy
  has_many :students, through: :marks

  belongs_to :teacher

  validates_presence_of :name, message: "Subject name can't be empty"
end
