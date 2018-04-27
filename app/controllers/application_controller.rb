class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  # def configure_premitted_parameters
  #   devise_parameter_sanitizer.for(:account_update) { |u|
  #   u.permit(:password, :password_confirmation, :current_password)
  #   }
  # end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
  end
end
