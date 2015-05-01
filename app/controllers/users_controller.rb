class UsersController < ApplicationController
  #login
  def new
    @user = User.new
  end

  #set the session
  def create
    @user = User.create :email => params[:user][:email], :password => params[:user][:password], :name => params[:user][:name]

    if @user.save
      flash[:success] = 'Signup Successful!'
      redirect_to root_path
    else
      flash[:danger] = 'Signup failed!'
      redirect_to new_user_path
    end
  end

  def index
    @posts = current_user.posts
  end
end