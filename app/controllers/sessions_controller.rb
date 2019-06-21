class SessionsController < ApplicationController
  skip_before_action :check_id, only: [:new, :create]
  def new
    return redirect_to home_path if curr_user
    @user = User.new
    render layout: "sign_up"
  end

  def create
    flash[:errors] ||= []
    user = User.find_by(username: params[:user][:username])
    if !user || !user.authenticate(params[:user][:password])
      flash[:errors] << "Credentials aren't valid"
      redirect_to login_form_path
    else
      session[:username] = user.username
      redirect_to home_path
    end
  end

  def destroy
    session.delete :username
    session.delete :from
    redirect_to root_path
  end
end
