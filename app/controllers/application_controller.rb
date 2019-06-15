class ApplicationController < ActionController::Base
  before_action :check_id 

  helper_method :curr_user
  def curr_user
    session[:username]
  end



  private
  def check_id
    redirect_to root_path if !curr_user
  end
end
