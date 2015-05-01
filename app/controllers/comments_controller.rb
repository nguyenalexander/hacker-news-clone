class CommentsController < ApplicationController

  def index
    @post = Post.find(params[:post_id])
    @comments = @post.comments
    @vote = Vote.new
    @votes = Vote.all
  end


  def create
    if params.key?(:post_id)
    @post = Post.find(params[:post_id])
    user_comment = @post.comments.find_by_user_id(current_user.id)
    current_user.created_comments << @post.comments.create(comment_params)
    elsif params.key?(:user_id)
      user = User.find(params[:post_id])
    else
      flash[:danger] = "invalid input"
    end
  redirect_to post_comments_path(@post)
  end



  private

  def comment_params
    params.require(:comment).permit(:body)
  end

end
