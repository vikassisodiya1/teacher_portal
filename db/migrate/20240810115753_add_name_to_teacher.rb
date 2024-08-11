# frozen_string_literal: true

class AddNameToTeacher < ActiveRecord::Migration[7.1]
  def change
    add_column :teachers, :first_name, :string
    add_column :teachers, :last_name, :string
  end
end
