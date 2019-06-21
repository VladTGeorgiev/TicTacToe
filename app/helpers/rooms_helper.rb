module RoomsHelper
  private
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

  def get_room
    Room.find(params[:id])
  end

  def get_opponent
    User.find(params[:room][:opponent_id])
  end

  def concede_prev_games
    Room.where(host: get_user).select {|room| room.tictactoe.status == "active"}.each {|room| room.tictactoe.update(status: "1")}
    Room.where(opponent: get_user).select {|room| room.tictactoe.status == "active"}.each {|room| room.tictactoe.update(status: "0")}
  end

  def create_a_room
    room = Room.create(host: get_user, opponent: get_opponent)
    room.create_tictactoe(player: 0, status: "active", boxes: Array.new(9))
    room
  end
end
