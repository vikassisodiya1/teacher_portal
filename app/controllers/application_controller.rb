# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def after_sign_in_path_for(resource)
    if resource.role == 'teacher'
      root_path # Replace with the actual route
    else
      super
    end
  end
end
