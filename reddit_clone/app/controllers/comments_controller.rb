class CommentsController < ApplicationController

  def new
    redirect_to post_url(params[:id])
  end

  def create
    @comment = current_user.comments.new(comment_params)
    if @comment.save
      if @comment.parent_comment_id.nil?
        redirect_to post_url(@comment.post)
      else
        redirect_to post_url(@comment.post)
      end
    else
      redirect_to post_url(@comment.post)
    end
  end

  def show

    @comment = Comment.find(params[:id])
    @child_comment = Comment.new
    render :show
  end
  private

  def comment_params
    params.require(:comment).permit(:content, :post_id, :parent_comment_id)
  end
end
