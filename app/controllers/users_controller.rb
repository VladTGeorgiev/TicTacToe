class UsersController < ApplicationController
  skip_before_action :check_id, only: [:new, :create]
  def new
    @user = User.new
  end
  def create
    if params[:user][:password] != params[:user][:confirm_password]
      flash[:errors] = ["Your passwords should match"]
      return redirect_to new_user_path
    end
    @user = User.create(params.require(:user).permit(:username, :password))
    if @user.valid?
      redirect_to root_path
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to new_user_path
    end
  end
  def show
    @user = User.find(params[:id])
  end
  def home
    @user = User.find_by(username: curr_user)
    @cont_room = Room.where(host: @user).find {|room| room.tictactoe.status == "active"}
    if !@cont_room
      @cont_room = Room.where(opponent: @user).find {|room| room.tictactoe.status == "active"}
    ende
  end


end
