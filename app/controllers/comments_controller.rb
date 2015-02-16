class CommentsController < ApplicationController

  def new
    @comment = Comment.new
    @user = User.find(params[:comment][:commentable_id])
    render :new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.author_id = current_user.id

    com_type = params[:comment][:commentable_type]

    if com_type == "User"
      @user = User.find(params[:comment][:commentable_id])
    else
      goal = Goal.find(params[:comment][:commentable_id])
      @user = User.find(goal.user_id)
    end

    if @comment.save
      redirect_to user_url(@user)
    else
      redirect_to user_url(@user)
    end
  end


  private

    def comment_params
      params.require(:comment).permit(:body, :commentable_id, :commentable_type)
    end

end
