class ApplicationController < ActionController::Base
  layout :layout_by_resource

  rescue_from Pundit::NotAuthorizedError, with: :render_404
  rescue_from ActionController::RoutingError, with: :render_404
  rescue_from ActiveRecord::RecordNotFound, with: :render_404

  protect_from_forgery with: :exception

  before_action :authenticate_user!
  before_action :set_locale
  before_action :configure_permitted_parameters, if: :devise_controller?

  def render_404
    render template: 'errors/error404', layout: 'layouts/devise_layout'
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :second_name, :surname, :email, :password, :password_confirmation])
  end

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  ### Layout section begin
  def layout_by_resource
    if devise_controller? && !signed_in?
      "devise_layout"
    else
      "application"
    end
  end
end
