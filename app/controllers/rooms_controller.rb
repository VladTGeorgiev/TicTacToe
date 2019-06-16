class RoomsController < ApplicationController

  def create
    user = User.find_by(username: curr_user)
    room = Room.create(host: user).create_tictactoe(player: 0, status: "active")
    redirect_to room_path(id: room.id)
  end

  def update
    room = Room.find(params[:id])
    flash[:errors] ||= []
    if !params[:game] || !params[:game][:boxes]
      if room.curr_player?(curr_user)
        flash[:errors] << "You have to mark at least one box to make a turn"
      else
        flash[:errors] << "It is not your turn yet"
      end
      return redirect_to room_path(room)
    end
    selections = params[:game][:boxes]
    if selections.keys.size > 1
      flash[:errors] << "You cannot select more than one box"
    else
      game = room.tictactoe
      game.next_turn(selections)
      game.next_player unless game.won? || game.draw?
      sleep 12
    end
    redirect_to room_path(room)
  end


  def show
    @room = Room.find(params[:id])
    @game = @room.tictactoe
    if @game.status == "draw"
      render :draw
    elsif @game.status == curr_player(@room).to_s
      render :won
    elsif @game.status != "active"
      render :lost
    else
      @your_turn = @room.curr_player?(curr_user)
      render :"tictactoe/new", layout: "tictactoe"
    end
  end

  def show2

  end

  private
  def curr_player(room)
    room.player_num(curr_user)
  end
end
