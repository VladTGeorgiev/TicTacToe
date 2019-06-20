module ApplicationHelper
  def get_user
    User.find_by(username: curr_user)
  end

  def clear_errors
    flash[:errors] = []
  end

  def add_error(string)
    flash[:errors] ||= []
    flash[:errors] << string
  end

  def add_message(string)
    flash[:message] = string
  end
end
