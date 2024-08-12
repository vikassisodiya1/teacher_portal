# frozen_string_literal: true

class TeachersController < ApplicationController
  # before_action :after_sign_in_path_for
  before_action :authenticate_user!
  before_action :set_teacher, only: %i[show edit update destroy home_page]

  # POST /teachers or /teachers.json
  def create
    @teacher = Teacher.new(teacher_params)

    respond_to do |format|
      if @teacher.save
        format.html { redirect_to teacher_url(@teacher), notice: 'Teacher was successfully created.' }
        format.json { render :show, status: :created, location: @teacher }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @teacher.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /teachers/1 or /teachers/1.json
  def update
    respond_to do |format|
      if @teacher.update(teacher_params)
        format.html { redirect_to teacher_url(@teacher), notice: 'Teacher was successfully updated.' }
        format.json { render :show, status: :ok, location: @teacher }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @teacher.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teachers/1 or /teachers/1.json
  def destroy
    @teacher.destroy!

    respond_to do |format|
      format.html { redirect_to teachers_url, notice: 'Teacher was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def add_subject
    @students = Student.includes(:marks, :subjects).all
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_teacher
    @teacher = current_user
  end

  # Only allow a list of trusted parameters through.
  def teacher_params
    params.fetch(:teacher, {})
  end
end
