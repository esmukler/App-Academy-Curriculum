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
      redirect_to user_url(user)
    else
      redirect_to new_session_url
    end
  end

  def destroy
    user = current_user
    log_out!(user)
    redirect_to new_session_url
  end


end
