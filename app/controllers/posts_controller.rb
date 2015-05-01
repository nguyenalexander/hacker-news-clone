class PostsController < ApplicationController
  #login

  before_action :is_authenticated?, unless:[:index, :show]

  def index
    @posts = Post.all
    @vote = Vote.new
    @votes = Vote.all
  end

  def new
    @post = current_user.posts.new
  end

  #set the session
  def create
    @post = current_user.posts.create post_params
    if @post.save
      flash[:success] = 'Post successful!'
      redirect_to posts_path
    else
      render 'new'
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to @post
    else
      render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :link)
  end

  # pushes vote created on a post into the user's ratings (user created vote)
  # u.cast_votes << Post.last.votes.create(value:-1)
  # pushes vote created on a user into the user's casted votes
  # u.cast_votes << User.last.votes.create(value:2)

end