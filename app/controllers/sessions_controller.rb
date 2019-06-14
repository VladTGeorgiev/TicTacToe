class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.find_by(username: params[:user][:username])
    if !user
      flash[:errors] = "Credentials aren't valid"
      redirect_to login_form_path
    else
      session[:username] = user.username
      redirect_to user_path(user)
    end
  end

  def destroy
    session.delete :username
    redirect_to root_path
  end
end
