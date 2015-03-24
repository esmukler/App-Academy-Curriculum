class CatsController < ApplicationController
  before_action :confirm_cat_owner, only: [:edit, :update]
  before_action :confirm_logged_in
  def index
    @cats = Cat.all.order(:id)
    render :index
  end

  def show
    @cat = Cat.find(params[:id])

    render :show
  end

  def new
    @cat = Cat.new

    render :new
  end

  def create
    @cat = Cat.new(cat_params)
    @cat.user_id = current_user.id

    if @cat.save
      flash[:notice] = "Welcome, #{@cat.name}!"
      redirect_to cat_url(@cat)
    else
      render :new
    end
  end

  def edit
    @cat = Cat.find(params[:id])

    render :edit
  end

  def update
    @cat = Cat.find(params[:id])

    if @cat.update(cat_params)
      flash[:notice] = "So #{@cat.name} got a new pair of shoes"
      redirect_to cat_url(@cat)
    else
      render :edit
    end
  end

  def destroy
    @cat = Cat.find(params[:id])
    flash[:notice] = "Sayonara #{@cat.name}"
    @cat.destroy!

    redirect_to cats_url
  end

  private

    def cat_params
      params.require(:cat).permit(:name, :color, :description, :sex, :birth_date)
    end

end
