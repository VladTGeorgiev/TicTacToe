class RoomsController < ApplicationController
  include RoomsHelper
  def new
    @opponents = User.order(:username)
  end

  def create
    opp_id = params[:room][:opponent_id]
    flash[:errors] = []
    if opp_id.to_i == get_user.id
      flash[:errors] << "Congradulations, you played yourself"
      return render :new
    end
    unfinished_game = Room.where(host_id: opp_id).find {|room| room.tictactoe.status == "active"}
    unfinished_game ||= Room.where(opponent_id: opp_id).find {|room| room.tictactoe.status == "active"}
    if unfinished_game
      flash[:errors] << "This opponent is currently playing with someone else"
      return render :new
    end
    concede_prev_games
    room = create_a_room
    redirect_to room_path(room)
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
    flash[:errors] ||= []
    @room = Room.find(params[:id])
    user = User.find_by(username: curr_user)
    if !(@room.host == user || @room.opponent == user)
      flash[:errors] << 'Your game was not found'
      return redirect_to home_path
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
