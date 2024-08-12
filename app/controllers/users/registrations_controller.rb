# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    build_resource({})
    resource.build_teacher # Initialize the teacher object if it doesn't exist
    respond_with resource
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up,
                                      keys: [:email, :password, :password_confirmation,
                                             { teacher_attributes: %i[first_name last_name experience
                                                                      qualification] }])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:email, :password, :password_confirmation,
                                                              { teacher_attributes: %i[first_name last_name experience
                                                                                       qualification] }])
  end
end
