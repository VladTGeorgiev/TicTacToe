class WelcomeController < ApplicationController
  def index
    redirect_to home_path if curr_user
    render :layout => false
  end
end
