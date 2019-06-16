class RoomsController < ApplicationController

  def create
    user = User.find_by(username: curr_user)
    cont_room = Room.where(host: user).find {|room| room.tictactoe.status == "active"}
    cont_room.tictactoe.update(status: "1") if cont_room
    cont_room_opp = Room.where(opponent: user).find {|room| room.tictactoe.status == "active"}
    cont_room_opp.tictactoe.update(status: "0") if cont_room_opp
    room = Room.create(host: user, opponent_id: 2).create_tictactoe(player: 0, status: "active")
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
    end
    redirect_to room_path(room)
  end


  def show
    @room = Room.find(params[:id])
    user = User.find_by(username: curr_user)
    if !(@room.host == user || @room.opponent == user)
      return render :no
    end
    @game = @room.tictactoe
    @your_turn = false if @game.status != "active"
    if @game.status == "draw"
      flash[:message] = "It is a draw"
    elsif @game.status == curr_player(@room).to_s
      flash[:message] = "You won!!!"
    elsif @game.status == "active"
      @your_turn = @room.curr_player?(curr_user)
    else
      flash[:message] = "You lost :("
    end
      @active = (@game.status == "active")
      render :"tictactoe/new", layout: "tictactoe"
  end

  def concede
    room = Room.find(params[:id])
    user = User.find_by(username: curr_user)
    winner = (room.host == user ? "1" : "0")
    room.tictactoe.update(status: winner)
    redirect_to room_path(room)
  end

  private
  def curr_player(room)
    room.player_num(curr_user)
  end
end
