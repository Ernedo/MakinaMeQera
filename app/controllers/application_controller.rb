class ApplicationController < ActionController::Base
  # before_action :configure_permitted_parameters, if: :devise_controller?
  #
  #  protected
  #
  #  def configure_permitted_parameters
  #    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:firstname, :lastname, :current_password, :password, :password_confirmation) }
  #  end
end
