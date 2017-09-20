class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_locale

  helper_method :categories, :current_order

  private

  def categories
    @categories ||= Category.all
  end

  def current_order
    @current_order ||= CurrentOrder.new(self).call
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    locale = (I18n.locale == I18n.default_locale ? nil : I18n.locale)
    { locale: locale }
  end
end
