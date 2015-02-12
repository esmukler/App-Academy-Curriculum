class SessionsController < ApplicationController
  before_action :no_dup_login, only: [:new, :create]

  def new
    render :new
  end

  def create
    user = User.find_by_credentials(params[:user][:email],
                                    params[:user][:password])
    if user
      log_in!(user)
      redirect_to bands_url
    elsif User.find_by_email(params[:user][:email])
      flash[:errors] = ["the password you entered does not match our records"]
      redirect_to new_session_url
    else
      flash[:errors] = ["we don't have a user by that name in our records"]
      redirect_to new_session_url
    end
  end

  def destroy
    user = current_user
    log_out!(user)
    redirect_to new_session_url
  end


end
