class PostsController < ApplicationController
  #login

  before_action :is_authenticated?, unless:[:index, :show]

  def index
    @posts = Post.all
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

  private

  def post_params
    params.require(:post).permit(:title, :link)
  end
end