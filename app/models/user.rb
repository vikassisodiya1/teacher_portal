# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :teacher, dependent: :destroy
  accepts_nested_attributes_for :teacher

  before_save :default_role

  def default_role
    self.role = 'teacher'
  end
end
