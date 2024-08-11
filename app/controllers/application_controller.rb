# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def after_sign_in_path_for(resource)
    if resource.email == 'test1@example.com'
      teachers # Replace with the actual route
    else
      super
    end
  end
end
