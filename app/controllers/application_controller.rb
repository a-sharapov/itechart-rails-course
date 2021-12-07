class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def current_user
    UserDecorator.decorate(super) unless super.nil?
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  rescue
    render_404
  end

  def render_404
    render template: '/layouts/404', status: :not_found
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update) { 
      |u| u.permit(:name, :email, :password, :current_password)
    }
  end
end
