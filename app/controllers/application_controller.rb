class ApplicationController < ActionController::Base
  include Pundit
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from Pundit::NotAuthorizedError do |exception|
    flash[:error] = "You are not authorized to perform this action."
    redirect_to root_url
  end

  def after_sign_in_path_for(resource)
    user_path(current_user)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
  end
end
