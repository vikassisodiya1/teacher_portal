# frozen_string_literal: true

class SubjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_teacher

  def new
    @subject = @teacher.subjects.build
  end

  def create
    @subject = @teacher.subjects.build(subject_params)
    respond_to do |format|
      if @subject.save
        format.turbo_stream { render turbo_stream: root_path, notice: 'Subject was successfully added.' }
        format.json { render :index, status: :created, location: @subject }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @subject.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_teacher
    @teacher = Teacher.find(params[:teacher_id])
  end

  def subject_params
    params.require(:subject).permit(:name)
  end
end
