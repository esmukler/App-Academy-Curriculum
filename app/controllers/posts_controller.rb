class PostsController < ApplicationController
  before_action :is_author, only: [:edit, :update, :destroy]

  def index
    @sub = Sub.find(params[:id])
    redirect_to sub_posts(@sub)
  end

  def new
    @post = Post.new

    render :new
  end

  def create
    @post = current_user.authored_posts.new(post_params)
    if @post.save
      redirect_to post_url(@post)
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
    render :edit
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_url(@post)
    else
      render :edit
    end
  end

  def show
    @post = Post.find(params[:id])
    render :show
  end

  def destroy

  end

  private

  def post_params
    params.require(:post).permit(:title,:url,:content, sub_ids: [])
  end

  def is_author
    unless current_user.id == Post.find(params[:id]).author_id
      redirect_to :back
    end
  end

end
