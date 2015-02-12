class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # TODO protect_from_forgery with: :exception
  helper_method :current_user, :is_logged_in

  def log_in!(user)
    @current_user = user
    session[:session_token] = user.session_token
  end

  def log_out!(user)
    user.reset_session_token!
    session[:session_token] = nil
  end

  def current_user
    return nil if session[:session_token].nil?
    User.find_by_session_token(session[:session_token])
  end

  def is_logged_in
    !!current_user
  end

  private

    def no_dup_login
      redirect_to user_url(current_user) if is_logged_in
    end

    def require_login
      redirect_to new_session_url unless is_logged_in
    end

end
