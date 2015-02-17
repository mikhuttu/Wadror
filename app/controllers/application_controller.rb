class ApplicationController < ActionController::Base
  protect_from_forgery

  # määritellään, että metodit tulevat käyttöön myös näkymissä
  helper_method :current_user, :admin

  def current_user
    return nil if session[:user_id].nil?
    User.find(session[:user_id])
  end

  def admin
    return false if session[:user_id].nil?
    current_user.admin
  end

  def ensure_that_admin
    redirect_to "/", notice:'You do not have the permission to do this.' if not admin
  end

  def ensure_that_signed_in
    redirect_to signin_path, notice:'You should be signed in.' if current_user.nil?
  end

end
