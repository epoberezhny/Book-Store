class ApplicationController < ActionController::Base
  include ShoppingCart::Controllers::OrderHelpers
  
  protect_from_forgery with: :exception

  before_action :set_locale

  helper_method :categories

  rescue_from CanCan::AccessDenied do
    redirect_back(fallback_location: root_path, alert: t('denied'))
  end

  private

  def categories
    @categories ||= Category.all
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    { locale: I18n.locale == I18n.default_locale ? nil : I18n.locale }
  end
end
