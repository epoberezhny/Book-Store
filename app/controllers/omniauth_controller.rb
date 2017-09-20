class OmniauthController < ApplicationController
  def localized
    session[:locale] = I18n.locale
    redirect_to omniauth_authorize_path('user', params[:provider])
  end
end