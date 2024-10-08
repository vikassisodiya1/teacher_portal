# frozen_string_literal: true

class CreateStudents < ActiveRecord::Migration[7.1]
  def change
    create_table :students do |t|
      t.string :first_name
      t.string :last_name

      t.timestamps
    end
  end
end
