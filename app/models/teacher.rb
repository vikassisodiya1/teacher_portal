# frozen_string_literal: true

class Teacher < ApplicationRecord
  belongs_to :user
  has_many :subjects, dependent: :destroy
end
