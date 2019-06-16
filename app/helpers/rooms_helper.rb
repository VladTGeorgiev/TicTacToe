module RoomsHelper
  private
  def get_user
    User.find_by(username: curr_user)
  end

  def concede_prev_games
    Room.where(host: get_user).select {|room| room.tictactoe.status == "active"}.each {|room| room.tictactoe.update(status: "1")}
    Room.where(opponent: get_user).select {|room| room.tictactoe.status == "active"}.each {|room| room.tictactoe.update(status: "0")}
  end

  def create_a_room
    Room.create(host: get_user, opponent_id: params[:room][:opponent]).create_tictactoe(player: 0, status: "active")
  end
end
