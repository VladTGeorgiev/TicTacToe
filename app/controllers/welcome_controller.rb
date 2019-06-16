class WelcomeController < ApplicationController
  skip_before_action :check_id
  def index
    return redirect_to home_path if curr_user
  end
end
