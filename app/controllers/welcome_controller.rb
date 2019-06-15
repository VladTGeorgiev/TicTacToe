class WelcomeController < ApplicationController
  skip_before_action :check_id 
  def index
    redirect_to home_path if curr_user
    render :layout => false
  end
end
