class UsersController < ApplicationController
  before_action :avoid_dup_login

  def new

  end

  def create
    @user = User.new(user_params)
    flash[:notice] = "Welcome, #{@user.username}!"
    log_in(@user)
  end

  private

    def user_params
      params.require(:user).permit(:username, :password)
    end

end
