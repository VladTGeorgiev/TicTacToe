class ApplicationController < ActionController::Base
  helper_method :curr_user
  def curr_user
    session[:username]
  end
end
