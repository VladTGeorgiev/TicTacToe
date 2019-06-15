class RoomsController < ApplicationController

  def create
    user = User.find_by(username: curr_user)
    room = Room.create(host: user).create_tictactoe(player: 0)
    redirect_to room_path(room)
  end

  def update

    room = Room.find(params[:id])
    game = room.tictactoe

    game.next_turn(params[:game][:boxes])

    sleep 15
    redirect_to room_path(room)
  end


  def show
    @room = Room.find(params[:id])
    @game = @room.tictactoe



    render :"tictactoe/new", layout: "tictactoe"
  end

  def show2

  end
end
