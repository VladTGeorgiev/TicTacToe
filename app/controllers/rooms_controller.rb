class RoomsController < ApplicationController

  def create
    user = User.find_by(username: curr_user)
    room = Room.create(host: user).create_tictactoe
    redirect_to room_path(room)
  end

  def update
    room = Room.find(params[:id])
    game = room.tictactoe

    arr = game.boxes.dup
    params[:game][:boxes].each do |i, check|
      arr[i.to_i] = !!check
    end

    game.update(boxes: arr)

    redirect_to room
  end


  def show
    @room = Room.find(params[:id])
    @game = @room.tictactoe
    render :"tictactoe/new", layout: "tictactoe"
  end

  def show2

  end
end
