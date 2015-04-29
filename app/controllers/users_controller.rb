class UsersController < ApplicationController
  #login
  def new
    @user = User.new
  end

  #set the session
  def create
    User.create :email => params[:user][:email], :password => params[:user][:password], :name => params[:user][:name]

    if @user
      flash[:success] = 'Signup Successful!'
      redirect_to root_path
    else
      flash[:danger] = 'Signup failed!'
      redirect_to signup_path
    end
  end

  def index
    @posts = current_user.posts
  end
end