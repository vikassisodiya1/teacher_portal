class StudentsController < ApplicationController
  before_action :authenticate_user!
  # before_action :set_student, only: [:edit, :update, :destroy]

  def index
    byebug
    @student=Student.all
  end

  def new
    @student = Student.new
    @student.marks.build.build_subject # Prepare nested fields for subjects and marks
  end

  def create
    @student = Student.new(student_params)

    if @student.save
      redirect_to students_path, notice: 'Student and associated subjects/marks were successfully created.'
    else
      render :new
    end
  end

  private

  def student_params
    params.require(:student).permit(
      :name,
      marks_attributes: [
        :id, :score, :subject_id, subject_attributes: [:id, :name]
      ]
    )
  end

end
