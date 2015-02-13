class SubsController < ApplicationController

  def new
    @sub = Sub.new

    render :new
  end

  def index
    @subs = Sub.all

    render :index
  end

  def create
    @sub = current_user.moderated_subs.new(sub_params)
    if @sub.save
      redirect_to sub_url(@sub)
    else
      render :new
    end
  end

  def edit
    @sub = current_user.moderated_subs.find(params[:id])
    render :edit
  end

  def update
    @sub = Sub.find(params[:id])
    if @sub.update(sub_params)
      redirect_to sub_url(@sub)
    else
      render :edit
    end
  end

  def show
    @sub = Sub.find(params[:id])
    render :show
  end

  private

  def sub_params
    params.require(:sub).permit(:title, :description)
  end

end
