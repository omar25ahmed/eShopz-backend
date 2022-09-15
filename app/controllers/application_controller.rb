class ApplicationController < ActionController::API
  include RackSessionFix
  load_and_authorize_resource unless: :devise_controller?
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit(:first_name, :last_name, :email, :password, :country, :phone, :image)
    end
    devise_parameter_sanitizer.permit(:sign_in) { |u| u.permit(:email, :password) }
  end

  rescue_from CanCan::AccessDenied do
    render json: { error: 'You are not authorized to access this page.' }, status: :unauthorized
  end
end
