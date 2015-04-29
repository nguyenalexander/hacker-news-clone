class SessionsController < ApplicationController

  #login
  def new
  end

  #set the session
  def create
    @user = User.authenticate(params[:user][:email], params[:user][:password])

    if @user
      session[:user_id] = @user.id
      flash[:success] = 'Login Successful!'
      redirect_to root_path
    else
      flash[:danger] = 'Invalid login credentials'
      render :new
    end
  end

  #delete session
  def destroy
    session[:user_id] = nil
    flash[:info] = "User has logged out"
    redirect_to login_path
  end

end