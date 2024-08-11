# frozen_string_literal: true

class StudentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_student, only: %i[edit update destroy]
  PAGE_NO = 1

  def index
    @students = Student.includes(:marks, :subjects)
                       .order(created_at: :desc)
                       .paginate(page: params[:page] || PAGE_NO, per_page: 10)
  end

  def new
    @student = Student.new
    @subjects = Subject.all
    @student.marks.build # Prepare nested fields for marks
  end

  def edit
    @subjects = Subject.all
  end

  def update
    respond_to do |format|
      if @student.update(student_params)
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace("student_#{@student.id}",
                                                    partial: 'row', locals: { student: @student, mark: @student.marks.first }), notice: 'Student was successfully updated.' # rubocop:disable Layout/LineLength
        end
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @student.destroy
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove("student_#{@student.id}") }
      format.html { redirect_to root_path, notice: 'Student was successfully destroyed.' }
    end
  end

  def create # rubocop:disable Metrics/MethodLength
    @student = Student.new(student_params)
    respond_to do |format|
      if @student.save
        format.turbo_stream do
          render turbo_stream: turbo_stream.prepend(
            :student, partial: 'row', locals: { student: @student,
                                                mark: @student.marks.first }
          ), notice: 'Student and associated subjects/marks were successfully created.'
        end
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  private

  def student_params
    params.require(:student).permit(
      :first_name, :last_name,
      marks_attributes: %i[
        id score subject_id
      ]
    )
  end

  def set_student
    @student = Student.find(params[:id])
  end
end
