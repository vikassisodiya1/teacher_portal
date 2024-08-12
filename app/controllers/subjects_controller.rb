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
        flash.now[:notice] = 'Subject was successfully added.'
      else
        flash.now[:alert] = @subject.errors.full_messages.last
      end
      format.turbo_stream { render turbo_stream: turbo_stream.append('flash', partial: 'layouts/flash') }
    end
  end

  private

  def set_teacher
    @teacher = current_user.teacher
  end

  def subject_params
    params.require(:subject).permit(:name)
  end
end
