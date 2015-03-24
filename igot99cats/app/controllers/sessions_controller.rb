class SessionsController < ApplicationController
  before_action :avoid_dup_login, except: :destroy

  def new
    # log in page
  end

  def create
    user = User.find_by_credentials( params[:user][:username],
                                      params[:user][:password] )

    # !@user.nil? ? log_in(@user) : redirect_to new_session_url
    if user
      log_in(user)
    else
      redirect_to new_session_url
    end
  end

  def destroy
    log_out(current_user)
  end

end
