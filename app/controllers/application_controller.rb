class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include MetaTagHelper

  before_action :http_auth_for_staging, :set_locale

  def default_url_options
    # SUPPORT: SSL
    # { protocol: "https" }
    {}
  end

  private

  def set_locale
    if params[:locale] && I18n.available_locales.include?( params[:locale].to_sym )
      session[:locale] = params[:locale]
    end

    I18n.locale = session[:locale] || I18n.default_locale
  end

  def http_auth_for_staging
    return unless Rails.env.staging?
    authenticate_or_request_with_http_basic do |username, password|
      username == "myapp" && password == "myapp"
    end
  end
end
