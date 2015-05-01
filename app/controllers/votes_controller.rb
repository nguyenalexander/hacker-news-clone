class VotesController < ApplicationController

  def index
    @votes = Vote.all
  end

  def create
    if params.key?(:post_id)
    post = Post.find(params[:post_id])
    user_vote = post.votes.find_by_user_id(current_user.id)
      if user_vote.nil?
        current_user.cast_votes << post.votes.create(vote_params)
      else
        if(params[:vote][:value].to_i != user_vote.value)
          user_vote.value = params[:vote][:value]
          user_vote.save
        else
        flash[:danger] = "You've already voted, dingus!"
        end
      end
    elsif params.key?(:user_id)
      user = User.find(params[:post_id])
    elsif params.key?(params[:comment_id])
    comment = Comment.find(params[:comment_id])
    user_vote = comment.votes.find_by_user_id(current_user.id)
      if user_vote.nil?
        current_user.cast_votes << comment.votes.create(vote_params)
      else
        if(params[:vote][:value].to_i != user_vote.value)
          user_vote.value = params[:vote][:value]
          user_vote.save
        else
        flash[:danger] = "You've already voted, dingus!"
        end
      end
    else
      flash[:danger] = "invalid input"
    end
  redirect_to :posts
  end

  # def user_vote_create post
  #   current_user.cast_votes << post.votes.create(vote_params)
  # end

  # def user_limit user, post
  #   if (user.value == current_user.cast_votes.find_by_votable_id(params[:post_id]).value)
  #     current_user.cast_votes << post.votes.create(value:params[:value])
  #   end
  # end

  def vote_params
    params.require(:vote).permit(:value)
  end

end