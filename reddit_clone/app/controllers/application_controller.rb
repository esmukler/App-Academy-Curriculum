class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # TODO protect_from_forgery with: :exception
  helper_method :is_logged_in, :current_user

  def log_out!(user)
    user.reset_session_token!
    session[:token] = nil
  end

  def log_in!(user)
    session[:token] = user.reset_session_token!
  end

  def is_logged_in
    !!current_user
  end

  def current_user
    return nil if session[:token].nil?
    User.find_by_session_token(session[:token])
  end

end
