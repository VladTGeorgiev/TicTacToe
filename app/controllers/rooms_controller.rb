class RoomsController < ApplicationController

  def create
    user = User.find_by(username: curr_user)
    room = Room.create(host: user).create_tictactoe(player: 0)
    redirect_to room_path(id: room.id)
  end

  def update

    room = Room.find(params[:id])
    game = room.tictactoe

    game.next_turn(params[:game][:boxes])
    game.next_player unless game.won? || game.draw?
    sleep 12
    redirect_to room_path(room)
  end


  def show
    @room = Room.find(params[:id])
    @game = @room.tictactoe
    if @game.status == "draw"
      render :draw
    elsif @game.status == @room.player_num(curr_user).to_s
      render :won
    elsif @game.status
      render :lost
    else
      render :"tictactoe/new", layout: "tictactoe"
    end
  end

  def show2

  end
end
