class Subject < ApplicationRecord
  has_many :marks, dependent: :destroy
  has_many :students, through: :marks

  belongs_to :teacher
end
