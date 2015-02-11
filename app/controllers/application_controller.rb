class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    return nil unless session[:token]
    User.find_by(session_token: session[:token])
  end

  def log_in(user)
    user.reset_session_token!
    session[:token] = user.session_token
    flash[:notice] = "Welcome back, #{current_user.username}!
                        You look very nice today."
    redirect_to cats_url
  end

  def log_out(user)
    flash[:notice] = "See ya very very soon, #{current_user.username}..."
    session[:token] = nil
    user.reset_session_token!
    redirect_to new_session_url
  end

  def logged_in?
    !!current_user
  end

  def current_cat
    if params[:controller] == "cats"
      Cat.find(params[:id])
    elsif params[:controller] == "cat_rental_requests"
      CatRentalRequest.find(params[:id]).cat
    end
  end

  def is_current_owner
    current_user == current_cat.owner
  end

  helper_method :current_user, :is_current_owner

  private

  def avoid_dup_login
    redirect_to cats_url if logged_in?
  end

  def confirm_cat_owner
    redirect_to cats_url unless is_current_owner
  end

  def confirm_logged_in
    redirect_to new_user_url unless logged_in?
  end

end
