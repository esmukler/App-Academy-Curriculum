class UsersController < ApplicationController

  def index
    render json: User.all
  end

  def create
    user = User.new(user_params)
    begin
      if user.save
        render json: user
      else
        render(
          json: user.errors.full_messages, status: :unprocessable_entity
        )
      end
    rescue
    end
  end

  def new
    render text: "I'm in the new action!"
  end

  def edit
    render text: "I'm in the edit action!"
  end

  def show
    render json: User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    user.update(user_params)
    render json: user
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    render json: User.all
  end

  protected
  def user_params
    params[:user].permit(:name, :email)
  end
end
