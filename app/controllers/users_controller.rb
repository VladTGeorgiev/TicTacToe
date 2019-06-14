class UsersController < ApplicationController
  def new
    @user = User.new
  end
  def create
    user = User.create(params.require(:user).permit(:username, :password_digest))
    redirect_to root_path
  end
  def show
    @user = User.find(params[:id])
  end
  def home
    @user = User.find_by(username: curr_user)
  end
end
